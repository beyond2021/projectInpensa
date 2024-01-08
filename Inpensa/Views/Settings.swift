//
//  Settings.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/19/23.
//

import SwiftUI

struct Settings: View {
    @AppStorage("userName") private var userName: String = ""
    // App loch Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesTobackground") private var lockWhenAppGoesTobackground: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("iKeevin", text: $userName)
                }
                Section("App Lock") {
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    if isAppLockEnabled {
                        Toggle("lock When App Goes To background", isOn: $lockWhenAppGoesTobackground)
                    }
                }

            }
            .navigationTitle("Settings")
            .background(.gray.opacity(0.25))
        }
    }
}

#Preview {
    ContentView()
}
