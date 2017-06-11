//
//  IBANTests.swift
//  IBANTests
//
//  Created by Bernd Rabe on 21.01.17.
//  Copyright © 2017 RABE_IT Services. All rights reserved.
//

import XCTest
import Hamcrest
import ISO3166_1Alpha2
@testable import IBAN

class IBANTests: XCTestCase {
    
    let correctFormattedGermanIBAN         = "de08700901001234567890"
    let correctFormattedInternationalIBAN  = "AL47212110090000000235698741"
    let correctFormattedCH                 = "CH10002300A1023502601"

    func test_Success_German() {
        guard let sut = try! IBAN(with: correctFormattedGermanIBAN) else {
            XCTFail("IBAN init failed")
            return
        }
        
        assertThat(sut, not(nilValue()))
        assertThat(sut.country == ISO3166_1Alpha2.de)
        print(sut)
    }
    
    func test_IBAN_CorrectFormat() {
        assertThat(try IBAN(with: correctFormattedGermanIBAN), not(nilValue()))
        assertThat(try IBAN(with: correctFormattedInternationalIBAN), not(nilValue()))
        assertThat(try IBAN(with: correctFormattedCH), not(nilValue()))
    }

    func test_IBAN_GermanIBAN_lengthExceeded() {
        let sut = correctFormattedGermanIBAN + "00"
        assertThrows(try IBAN(with: sut), IBANCreation.invalidLength)
    }

    func test_IBAN_CH_LI_IBAN_lengthExceeded() {
        let sut = correctFormattedCH + "00"
        assertThrows(try IBAN(with: sut), IBANCreation.invalidLength)
    }

    func test_IBAN_INT_IBAN_lengthExceeded() {
        let sut = correctFormattedInternationalIBAN + "00ABCDE"
        assertThrows(try IBAN(with: sut), IBANCreation.invalidLength)
    }
    
    func test_IBAN_WrongCountryCode() {
        let sut = "XX47212110090000000235698741"
        assertThrows(try IBAN(with: sut), IBANCreation.wrongCountryCode)
    }

    func test_IBAN_WrongCharacterSet() {
        let sut = "CH10002300A%023502601"
        assertThrows(try IBAN(with: sut), IBANCreation.invalidCharacters)
    }

    func test_IBAN_WrongFormat() {
        let sut = "CH1Z002300A1023502601"
        assertThrows(try IBAN(with: sut), IBANCreation.wrongFormat)
    }
    
    func test_IBAN_EmptyString() {
        assertThrows(try IBAN(with: ""), IBANCreation.invalidCharacters)
    }

}
