//
//  ReceiptEntryView.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 2/3/24.
//

import SwiftUI

struct ReceiptEntryView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "camera")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("scan your Recipt")
        }
        
    }
}

#Preview {
    ReceiptEntryView()
}
