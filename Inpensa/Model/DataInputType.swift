//
//  DataInputType.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 2/3/24.
//

import SwiftUI
enum DataInputType: String {
    case manual = "Manual"
    case voice = "Voice"
    case receipt = "Receipt"
    // Computed Property thus Var not func ViewBuilder
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .manual:
            TransactionsView()
        case.voice:
            VoiceEntryView()
        case .receipt:
            ReceiptEntryView()
        }}
}
