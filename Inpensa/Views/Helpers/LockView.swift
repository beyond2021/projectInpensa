//
//  LockView.swift
//  AppLock
//
//  Created by KEEVIN MITCHELL on 12/26/23.
//

import SwiftUI
import LocalAuthentication
// Custom View
struct LockView<Content: View>: View {
    // Lock Properties
    var lockType: LockType
    var lockPin: String
    var isEnabled: Bool
    var lockWhenAppGoesToBG: Bool = true // Optional in call already set
    @ViewBuilder var content: Content
    // View Properties
    @State private var pin: String = "" // 4 digit String
    // Forgot Pin
    var forgotPin: () -> Void = { } // ACTION
    @State private var animateField: Bool = false
    @State private var isUnlocked: Bool = false
    @State private var noBiometricAccess: Bool = false
    // Lock Context
    let context = LAContext()
    // Scene Phase
    @Environment(\.scenePhase) private var phase

    var body: some View {
        GeometryReader {
            let size = $0.size
            content
                .frame(width: size.width, height: size.height)

            if isEnabled && !isUnlocked {
                ZStack {
                    Rectangle()
                        .fill(.black)
                        .ignoresSafeArea()
                    if (lockType == .both && !noBiometricAccess) || lockType == .biometric {
                        // Biometrics
                        Group {
                            if noBiometricAccess {
                                Text("Enable Biometric Authentication in Settings to unlock this View")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                                    .padding(50)
                            } else {
                                // Biometric / Pin Unlock
                                VStack(spacing: 12) {
                                    VStack(spacing: 6) {
                                        Image(systemName: "lock")
                                            .font(.largeTitle)
                                        Text("Tap To Unlock")
                                            .font(.caption2)
                                            .foregroundStyle(.gray)
                                    }
                                    .frame(width: 100, height: 100)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        unlockedView()
                                    }
                                    if lockType == .both {
                                        Text("Enter Pin")
                                            .frame(width: 100, height: 40)
                                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                                            .containerShape(.rect)
                                            .onTapGesture {
                                                noBiometricAccess = true
                                            }
                                    }
                                }
                            }

                        }
                    } else {
                        // Custom number pad to enter code
                        numberPadPinView()

                    }

                }
                .environment(\.colorScheme, .dark)
                .transition(.offset(y: size.height + 100))

            }
        }
        .onChange(of: isEnabled, initial: true) { _, newValue in
            if newValue {
                unlockedView()
            }
        }
        // Locking when app goes to BG
        .onChange(of: phase) { _, newValue in
            if newValue != .active && lockWhenAppGoesToBG {
                isUnlocked = false
                pin = ""
            }
            // Ask for faceID after inActive
            if newValue == .active && !isUnlocked && isEnabled {
                // Avoid unessary faceID Pop Ups by cross verifying
                unlockedView()
            }

        }
    }
    // Get Biometric info
    private func unlockedView() {
        // Unlocking View after Check
        Task {
            if isBiometricsAvailable && lockType != .number {
                // Request Biometric Unlock
                if let result = try? await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock the View"),
                    result { withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                        isUnlocked = true
                    } completion: {
                        pin = ""
                    }

                }
            }
            // No Biometric || lockType must be set as Keypad
            // Updating Biometric state// View will go to the numberlock  - no biometric option
            noBiometricAccess = !isBiometricsAvailable
        }

    }
    private var isBiometricsAvailable: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)

    }
    // Number Pin View
    @ViewBuilder
    private func numberPadPinView() -> some View {
        VStack(spacing: 15) {
            Text("Enter Pin")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    if lockType == .both && isBiometricsAvailable {
                        Button(action: {
                            pin = ""
                            noBiometricAccess = false
                        }, label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .contentShape(.rect)
                        })
                        .tint(.white)
                        .padding(.leading)
                    }
                }
            // Adding Wrong PW wiggle animation using Keyframe animation
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                    // Showing pin by index
                        .overlay {
                            /// Safety Check
                            if pin.count > index {
                                let index = pin.index(pin.startIndex, offsetBy: index)
                                let string = String(pin[index])
                                // Entered Code PIN
                                Text(string)
                                    .font(.title.bold())
                                    .foregroundStyle(.black)

                            }
                        }

                }
            }
            .keyframeAnimator(initialValue: CGFloat.zero, trigger: animateField, content: { content, value in
                content
                    .offset(x: value)
            }, keyframes: { _ in
                KeyframeTrack {
                    CubicKeyframe(30, duration: 0.07)
                    CubicKeyframe(-30, duration: 0.07)
                    CubicKeyframe(20, duration: 0.07)
                    CubicKeyframe(-20, duration: 0.07)
                    CubicKeyframe(0, duration: 0.07)
                }
            })
            .padding(.top, 15)
            .overlay(alignment: .bottomTrailing, content: {
                Button("Forgot Pin?", action: forgotPin)
                // .font(.callout)
                    .foregroundStyle(.white)
                    .offset(y: 40)
            })
            .frame(maxHeight: .infinity)
            // Custom Number Pad
            GeometryReader { _ in
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
                    ForEach(1...9, id: \.self) { number in
                        // 1 to 8
                        Button(action: {
                            /// Add number to pin
                            ///  max limit 4
                            if pin.count <= 4 {
                                pin.append("\(number)")
                            }
                        }, label: {
                            Text("\(number)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .contentShape(.rect)
                        })
                        .tint(.white)

                    }
                    // 0 and Back Button (Delete)
                    Button(action: {
                        if !pin.isEmpty {
                            pin.removeLast()
                        }

                    }, label: {
                        Image(systemName: "delete.backward")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .contentShape(.rect)
                    })
                    .tint(.white)
                    Button(action: {
                        if pin.count < 4 {
                            pin.append("0")
                        }

                    }, label: {
                        Text("0")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .contentShape(.rect)
                    })
                    .tint(.white)
                })
                .frame(maxHeight: .infinity, alignment: .bottom)

            }
            .onChange(of: pin) {_, newValue in
                if newValue.count == 4 {
                    /// Validate Pin
                    if lockPin == pin {
                        // print("Unlocked")
                        withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                            isUnlocked = true
                        } completion: {
                            // Clearing pin
                            pin = ""
                            // Reset nUmberPad View
                            noBiometricAccess = !isBiometricsAvailable
                        }

                    } else {
                        // print("Wrong Pin")
                        pin = ""
                        animateField.toggle()
                    }
                }
            }
        }
        .padding()
        .environment(\.colorScheme, .dark)

    }
    // Lock Type
    enum LockType: String {
        case biometric = "Biometric Auth"
        case number = "Custom Number Lock"
        case both = "First preference will be biometric but if not available we will go to numlock"
    }
}

#Preview {
    ContentView()
}
