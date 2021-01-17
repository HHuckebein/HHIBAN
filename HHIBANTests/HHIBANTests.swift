//
//  IBANTests.swift
//  IBANTests
//
//  Created by Bernd Rabe on 21.01.17.
//  Copyright © 2017 RABE_IT Services. All rights reserved.
//

import XCTest
import ISO3166_1Alpha2
@testable import HHIBAN

class IBANTests: XCTestCase {
    
    let correctFormattedGermanIBAN         = "de08700901001234567890"
    let correctFormattedInternationalIBAN  = "AL47212110090000000235698741"
    let correctFormattedCH                 = "CH10002300A1023502601"

    func test_Success_German() {
        guard let sut = try! IBAN(with: correctFormattedGermanIBAN) else {
            XCTFail("IBAN init failed")
            return
        }
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.country, ISO3166_1Alpha2.de)
        print(sut)
    }
    
    func test_IBAN_CorrectFormat() {
        XCTAssertNotNil(try IBAN(with: correctFormattedGermanIBAN))
        XCTAssertNotNil(try IBAN(with: correctFormattedInternationalIBAN))
        XCTAssertNotNil(try IBAN(with: correctFormattedCH))
    }

    func test_IBAN_GermanIBAN_lengthExceeded() {
        let sut = correctFormattedGermanIBAN + "00"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.invalidLength)
        })
    }

    func test_IBAN_CH_LI_IBAN_lengthExceeded() {
        let sut = correctFormattedCH + "00"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.invalidLength)
        })
    }

    func test_IBAN_INT_IBAN_lengthExceeded() {
        let sut = correctFormattedInternationalIBAN + "00ABCDE"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.invalidLength)
        })
    }
    
    func test_IBAN_WrongCountryCode() {
        let sut = "XX47212110090000000235698741"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.wrongCountryCode)
        })
    }

    func test_IBAN_WrongCharacterSet() {
        let sut = "CH10002300A%023502601"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.invalidCharacters)
        })
    }

    func test_IBAN_WrongFormat() {
        let sut = "CH1Z002300A1023502601"
        XCTAssertThrowsError(try IBAN(with: sut), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.wrongFormat)
        })
    }
    
    func test_IBAN_EmptyString() {
        XCTAssertThrowsError(try IBAN(with: ""), "", { (error) in
            XCTAssertEqual(error as? IBANCreation, IBANCreation.invalidCharacters)
        })
    }

    func test_isIBAN() {
        XCTAssertTrue(correctFormattedGermanIBAN.isIBAN)
        XCTAssertTrue(correctFormattedInternationalIBAN.isIBAN)
        XCTAssertTrue(correctFormattedCH.isIBAN)
        XCTAssertFalse("CH10002300A%023502601".isIBAN)
        XCTAssertFalse("XX47212110090000000235698741".isIBAN)
        XCTAssertFalse("CH1Z002300A1023502601".isIBAN)
        XCTAssertFalse("".isIBAN)
    }
}
