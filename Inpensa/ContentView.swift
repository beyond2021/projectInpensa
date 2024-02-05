//
//  ContentView.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/12/23.
//
/*
 Expense tracker App
 1• Data Persistense : SwiftData
 2• Advance Filters and Search
 3• Data Visualization : Swift Charts
 4• Device Biometrics: App Lock
 5• App Widgets
 6• Custom Components and Animations
 */

import SwiftUI

struct ContentView: View {
    // Intro Visibility Status stored in the Phone
    @AppStorage("IsFirstTime") private var isFirstTime: Bool = true
    // Active tab
    @State private var activeTab: Tab = .recents
    // App loch Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesTobackground") private var lockWhenAppGoesTobackground: Bool = false
    
   
    var body: some View {
        LockView(lockType: .biometric, lockPin: "", isEnabled: isAppLockEnabled, lockWhenAppGoesToBG: lockWhenAppGoesTobackground) {
            TabView(selection: $activeTab) {
                Recents() // page view
                    .tag(Tab.recents)
                    .tabItem { Tab.recents.tabContent }// from enum
                Search()
                    .tag(Tab.search)
                    .tabItem { Tab.search.tabContent }// from enum
                Graphs()
                    .tag(Tab.chart)
                    .tabItem { Tab.chart.tabContent }// from enum
                Settings()
                    .tag(Tab.settings)
                    .tabItem { Tab.settings.tabContent }// from enum
               
            }
            .tint(appTint)
            // Intro Scene Presented on Sheet if Appstorage is set to true
            .sheet(isPresented: $isFirstTime, content: {
                IntroScene()
                    .interactiveDismissDisabled()

            })

        }

    }
  
}

#Preview {
    ContentView()
}
