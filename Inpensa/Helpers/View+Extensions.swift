//
//  View+Extensions.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/19/23.
//

import SwiftUI

extension View {
    // Modifiers
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center ) -> some View {
        self
        .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vSpacing(_ alignment: Alignment = .center ) -> some View {
        self
        .frame(maxHeight: .infinity, alignment: alignment)
    }
    // To Cover the Notch
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
            
        }
        return .zero
    }
    //MARK: Date
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
        
    }
    //MARK: Card View
    func currencyString(_ value: Double, allowedDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = allowedDigits
        return formatter.string(from: .init(value: value)) ?? ""
        
    }
    var currencySymbol: String {
        let local = Locale.current
        return local.currencySymbol ?? ""
    }
    // Running Total
    func total(_ transactions: [Transaction], category: Category) -> Double {
        return transactions.filter({ $0.category == category.rawValue }).reduce(Double.zero) { partialResult, transaction in
            return partialResult + transaction.amount
        }
    }
}
