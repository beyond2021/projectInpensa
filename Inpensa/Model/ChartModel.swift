//
//  ChartModel.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 1/2/24.
//

import SwiftUI

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    let totalValue: Double
    let category: Category
}

