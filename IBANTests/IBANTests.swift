//
//  IBANTests.swift
//  IBANTests
//
//  Created by Bernd Rabe on 21.01.17.
//  Copyright © 2017 RABE_IT Services. All rights reserved.
//

import XCTest
import Hamcrest
@testable import IBAN

class IBANTests: XCTestCase {
    
    let correctFormattedGermanIBAN         = "DE08700901001234567890"
    let correctFormattedInternationalIBAN  = "AL47212110090000000235698741"
    let correctFormattedCH                 = "CH10002300A1023502601"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_IBAN_CorrectFormat() {
        assertThat(try IBAN(withIBAN: correctFormattedGermanIBAN), not(nilValue()))
        assertThat(try IBAN(withIBAN: correctFormattedInternationalIBAN), not(nilValue()))
        assertThat(try IBAN(withIBAN: correctFormattedCH), not(nilValue()))
    }
}
