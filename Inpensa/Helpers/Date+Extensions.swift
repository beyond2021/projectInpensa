//
//  Date+Extensions.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/23/23.
//
import SwiftUI

extension Date {
    // Start Of Month and End of Month extractions from given date
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
        
    }
    
    var endtOfMonth: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .init(month: 1, minute: -1), to: self.startOfMonth) ?? self
        
    }
    
}
