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
    @available(iOSApplicationExtension, unavailable)
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero

        }
        return .zero
    }
    // MARK: Date
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)

    }
    // MARK: Card View
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
extension Color {
    public static var appOrange: Color {
        return Color(UIColor(red: 168/255, green: 87/255, blue: 81/255, alpha: 1.0))
    }
    public static var appPink: Color {
        return Color(UIColor(red: 201/255, green: 123/255, blue: 132/255, alpha: 1.0))
    }
    public static var appPurple: Color {
        return Color(UIColor(red: 125/255, green: 46/255, blue: 104/255, alpha: 1.0))
    }
    public static var appDarkBlue: Color {
        return Color(UIColor(red: 4/255, green: 9/255, blue: 38/255, alpha: 1.0))
    }
    public static var appBViolet: Color {
        return Color(UIColor(red: 37/255, green: 19/255, blue: 81/255, alpha: 1.0))
    }
}
