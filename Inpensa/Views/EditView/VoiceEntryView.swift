//
//  VoiceEntryView.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 2/3/24.
//

import SwiftUI

struct VoiceEntryView: View {
    var body: some View {
        Image(systemName: "mic")
            .font(.largeTitle)
            .fontWeight(.semibold)
        Text("Natural Language Entry")
    }
}

#Preview {
    VoiceEntryView()
}
