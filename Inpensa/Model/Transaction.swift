//
//  TransAction.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/17/23.
//

import SwiftUI
import SwiftData
@Model
class Transaction {
    /*let id: UUID = .init()*/ // Identifiable
    // Transaction Properties
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    // How to create a transaction
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue // From The Category Enum
        self.tintColor = tintColor.color // From TintColor Struct (String Passed In -
    }
    
    /*
     
     ChatGPT
     The @Transient property wrapper in SwiftUI is used to mark a property as transient, meaning that it is not persisted across state updates of the view. This is useful when you have a property that should not influence the view's state or lifecycle.
     
     */
    // Extracting color value from TintColor String - Computed var
    @Transient
    var color: Color {
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
 // Extracting Category and TintColor
    @Transient
    var tint: TintColor? {
        return tints.first(where: {$0.color == tintColor})
    }
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
    
    
}

