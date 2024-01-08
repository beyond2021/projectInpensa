//
//  IntroScene.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/12/23.
//

import SwiftUI

struct IntroScene: View {
    // Visibility States
    @AppStorage("IsFirstTime") private var isFirstTime: Bool = true // Set To True :1 in the Phone
    var body: some View {
        VStack( spacing: 15, content: {
            Text("What's New in\nInpensa")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)

            // Points View
            VStack(alignment: .leading, spacing: 25, content: {
                PointsView(symbol: "dollarsign", title: "Transactions", subTitle: "Keep track mof your earnings and expenses.")
                PointsView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphic reprsentations.")
                PointsView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expenses you want by advance search and filtering.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            Spacer(minLength: 10)
            /* when the button is tapped the AppStorage will be set to false  thus it wont appear again*/
            Button(action: {
                isFirstTime = false // Set To False
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14) // makes it thicker
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        })
        .padding(15)
    }
    // MARK: Points View
    @ViewBuilder
    func PointsView(symbol: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 20, content: {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundStyle(.gray)
            })
        })

    }
}

#Preview {
    IntroScene()
}
