//
//  DateFilterView.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/25/23.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    // Action date in returns void
    var onSubmit: (Date, Date) -> ()
    /* whenevr the submit button is clicked this will
     This will return the updated start and end date
     This will close the popup*/
    var onClose: () -> ()
    var body: some View {
            VStack(spacing: 15, content: {
                DatePicker("Start Date", selection: $start, displayedComponents: [.date])
                DatePicker("End Date", selection: $end, displayedComponents: [.date])
                HStack( spacing: 15, content: {
                    Button("Cancel") {
                        onClose()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(.red)
                    //
                    Button("Filter") {
                        onSubmit(start, end)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(appTint)
                })
                .padding(.top, 10)
                .background(.bar, in: .rect(cornerRadius: 10))
                .padding(.horizontal, 30)
            })
            .padding(15)
       
    }
}

