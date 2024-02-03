//
//  Tab.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/12/23.
//
/* Creating an enum that will return the Tab Item Labels for our tab view*/

import SwiftUI

enum Tab: String {
    // FDinite Options
    case recents = "Recents"
    case search = "Search"
    case chart = "Chart"
    case settings = "Settings"

    // Computed Property thus Var not func ViewBuilder
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        case .chart:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
        

    }

}
