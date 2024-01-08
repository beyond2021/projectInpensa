//
//  InpensaTests.swift
//  InpensaTests
//
//  Created by KEEVIN MITCHELL on 1/7/24.
// Testing The Domain Logic
import SwiftData
import XCTest
@testable import Inpensa

final class BaseTestCase: XCTestCase {
    private var context: ModelContext!
    // Create the Model Context
    // Ran Before Any Test
    @MainActor
    override func setUp() {
        context = mockContainer.mainContext
    }
   
    // Setup
    
    

  
}
