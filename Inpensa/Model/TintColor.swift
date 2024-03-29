//
//  TintColor.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/17/23.
//

import SwiftUI

// Custom TintColor for different TranasActions
// Each Color has an ID - Identufiable
struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String // Linked To Transaction Model
    var value: Color
}

// Available Colors Array
//var tints: [TintColor] = [
//    .init(color: "Red", value: .red), // .init creates a color
//    .init(color: "Blue", value: .blue),
//    .init(color: "Red", value: .red),
//    .init(color: "Blue", value: .blue),
//    .init(color: "Brown", value: .brown),
//    .init(color: "Orange", value: .orange)
//]

var appTints: [TintColor] = [
    .init(color: "AppViolet", value: .appBViolet), // .init creates a color
    .init(color: "InpensaOrange", value: .appOrange),
    .init(color: "InpensaPink", value: .appPink),
    .init(color: "InpensaPurple", value: .appPurple),
    .init(color: "oxfordBlue", value: .appDarkBlue),
   // .init(color: "Orange", value: .orange)

]
