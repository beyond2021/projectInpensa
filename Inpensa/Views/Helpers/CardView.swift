//
//  CardView.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/23/23.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var body: some View {
        ZStack {
            // Color("InpensaPink")
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.appBViolet)
                
               
            VStack(spacing: 0, content: {
                HStack( spacing: 12, content: {
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                        .foregroundStyle(.white)
//                        .foregroundStyle(Color.primary) // foregroungstyle primary means the apps accent color,  to get the system's primary color we need to use color,primary.
                    Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(expense > income ? .red : .green)
                })
                .padding(.bottom, 25)
                HStack( spacing: 0, content: {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let tint = category == .income ? appTint : Color.red
                        HStack(spacing: 10) {
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                               // .foregroundStyle(tint)
                                .foregroundStyle(.white)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text(currencyString(category == .income ? income: expense, allowedDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
//                                    .foregroundStyle(.primary)
                                    .foregroundStyle(.white)
                            }
                            if category == .income {
                                Spacer(minLength: 10)
                            }

                        }

                    }
                })
            })
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }
    }
}

#Preview {
    ScrollView {
        CardView(income: 4590, expense: 2389)

    }

}
