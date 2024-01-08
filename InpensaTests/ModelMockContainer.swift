//
//  ModelMockContainer.swift
//  InpensaTests
//
//  Created by KEEVIN MITCHELL on 1/7/24.
//

import Foundation
import SwiftData
@MainActor
var mockContainer: ModelContainer {
    do {
        let container = try ModelContainer(for: Transaction.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)) // false My resposibility to delete the data somehow
        return container
    } catch {
        fatalError("Failed to create container")
    }
    
}
