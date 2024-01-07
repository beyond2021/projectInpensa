//
//  InpensaApp.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/12/23.
//
/* Building Home View With 4 tabs, Show the intro screen if app storage is true*/

import SwiftUI
import WidgetKit

@main
struct InpensaApp: App {
    @Environment(\.scenePhase) private var scene
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scene, { oldValue, newValue in
                    if newValue == .background {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                })
        }
        .modelContainer(for: [Transaction.self])
    }
}
