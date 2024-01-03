//
//  InpensaApp.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/12/23.
//
/* Building Home View With 4 tabs, Show the intro screen if app storage is true*/

import SwiftUI

@main
struct InpensaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
