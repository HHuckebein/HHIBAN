//
//  IBAN.swift
//  IBAN
//
//  Created by Bernd Rabe on 21.01.17.
//  Copyright © 2017 RABE_IT Services. All rights reserved.
//

import Foundation
import ISO3166_1Alpha2

/* @brief Validates a given IBAN against ISO 13616:2007
 Sanity check is defined by ECBS (European Committee for Banking Standards).
 Calculation according ISO 7064 per Modulo 97-10.
 @ref http://www.iban.de/iban-pruefsumme.html
 @ref http://www.pruefziffernberechnung.de/Originaldokumente/IBAN/Prufziffer_07.00.pdf
 @ref http://en.wikipedia.org/wiki/International_Bank_Account_Number
 IBAN Construction (Germany)
 LL - (Country Code)      2 digits (conforms to ISO 3166-1 alpha-2)
 PZ - (check digit)       2 digits
 BLZ - (sorting code)     8 digits
 KTO - (account number)   10 digits (if shorted head padded with 0)
 International IBAN can have a length for the so called BBAN (Basic
 Banking Account Number, consisting of BLZ and KTO, of 30.
 */

enum IBANCreation: Error {
    case invalidCharacters
    case wrongCountryCode
    case invalidLength
    case invalidChecksum
    case wrongFormat
}

public struct IBAN {
    struct Constants {
        static let lengthDE    = 22
        static let lengthCH_LI = 21
        static let lengthINT   = 34
        static let countryCodeRange = Range(0..<2)
        static let checkSumRange = Range(2..<4)
    }
    
    fileprivate static var checkSum = 0
    
    let value: String
    let country: ISO3166_1Alpha2
    
    init?(with iban: String) throws {
        if iban.isValidCharacterSet == false {
            throw IBANCreation.invalidCharacters
        }
        
        // Country Code check
        guard let countryCodeRange = iban.convertRange(range: Constants.countryCodeRange) else  {
            print("range convertion failed")
            return nil
        }
        
        let countryCodeString = iban.substring(with: countryCodeRange)
        guard let country = ISO3166_1Alpha2(value: countryCodeString) else {
            throw IBANCreation.wrongCountryCode
        }
        
        // Length check
        
        let count = iban.characters.count
        if country == .de, count > Constants.lengthDE {
            throw IBANCreation.invalidLength
        }

        if country == .li || country == .ch, count > Constants.lengthCH_LI {
            throw IBANCreation.invalidLength
        }
        
        if count > Constants.lengthINT {
            throw IBANCreation.invalidLength
        }
        
        // Checksum check
        
        guard let checkSumRange = iban.convertRange(range: Constants.checkSumRange) else  {
            print("range convertion failed")
            return nil
        }

        guard let sum = Int(iban.substring(with: checkSumRange)) else  {
            throw IBANCreation.wrongFormat
        }
        
        IBAN.checkSum = sum
        
        // create a new string from by removing the checksum and moving
        // the country to the end of the string ccssxxx -> xxxcc
        // the prepare for checksum calculation
        
        // 1. the final string without checksum
        var transformedIBAN = iban.substring(from: checkSumRange.upperBound) + iban.substring(with: countryCodeRange)
        // 2. uppercase without spaces
        guard let uppercasedNoSpaces = transformedIBAN.applyingTransform(.toUppercaseNoSpaces, reverse: false) else {
            throw IBANCreation.invalidChecksum
        }
        transformedIBAN = uppercasedNoSpaces
        
        // 3. transform: map A..Z to 10..35
        transformedIBAN = transformedIBAN.characters.map({ $0.transformed }).reduce("", { $0 + $1 }) + "00"
        
        if transformedIBAN.isModulo9710 == false {
            throw IBANCreation.invalidChecksum
        }
        
        self.country = country
        self.value = iban
    }
}

extension IBAN: CustomStringConvertible {
    public var description: String {
        let count = value.characters.count / 4
        var formatted = value
        for index in (0..<count).reversed() {
            let insertIdx = formatted.index(formatted.startIndex, offsetBy: (index + 1) * 4)
            formatted.insert(" ", at: insertIdx)
        }
        return formatted
    }
}

// MARK: - Helper Functions

fileprivate extension StringTransform {
    static let toUppercaseNoSpaces = StringTransform(rawValue: "Upper; [:Separator:] Remove;")
}

fileprivate extension Character {
    /** Maps
    */
    var transformed: String {
        if "A"..."Z" ~= String(self) {
            let base = ("A" as NSString).character(at: 0)
            let own = (String(self) as NSString).character(at: 0)

            return String(own - base + 10)
        } else {
            return String(self)
        }
    }
}

fileprivate extension String {
    var isValidCharacterSet: Bool {
        let pred = NSPredicate(format: "SELF MATCHES '[0-9a-zA-Z ]+'")
        return pred.evaluate(with: self)
    }
    
    var isModulo9710: Bool {
        if characters.count >= 9 {
            let idx = index(startIndex, offsetBy: 9)
            
            guard var number = Int(substring(to: idx)) else {
                return false
            }
            number %= 97
            let newString = String(number) + substring(from: idx)
            return newString.isModulo9710
        }
        
        guard let number = Int(self) else {
            return false
        }
        let rest = 98 - number % 97
        return rest == IBAN.checkSum
    }

    // convert a given Range<Int> into Range<String.Index>, if possible
    func convertRange(range: Range<Int>) -> Range<String.Index>? {
        guard
            let startIdx = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let endIdx = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
            else {
                print("Getting String.Index out of \(range) failed")
                return nil
        }
        return Range<String.Index>(startIdx..<endIdx)
    }
}
