//
//  Currency.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation

struct Currency:Identifiable, Codable, Equatable {
    var id = UUID()
    
    var countryName:String?
    var countryCode:String?
    var currencyCode:String?
    var currencyName:String?
    var currencySymbol:String?
    
    var currencyShortName:String? {
        let words = currencyName!.byWords
        return String(describing: words.last!)
    }
    
    init(countryName: String? = nil, countryCode: String? = nil, currencyCode: String? = nil, currencyName: String? = nil, currencySymbol: String? = nil) {
        self.countryName = countryName
        self.countryCode = countryCode
        self.currencyCode = currencyCode
        self.currencyName = currencyName
        self.currencySymbol = currencySymbol
    }
    
    private enum codingKeys: String, CodingKey {
        case countryName, countryCode, currencyCode, currencyName, currencySymbol
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
        self.currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode)
        self.currencyName = try container.decodeIfPresent(String.self, forKey: .currencyName)
        self.currencySymbol = try container.decodeIfPresent(String.self, forKey: .currencySymbol)
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.id == rhs.id
    }
 }

extension Currency:CustomStringConvertible {
    var description: String {
        return "\nCountryCode   : \(self.countryCode!)\nName         : \(self.countryName!)\nCurrencyCode : \(self.currencyCode!)\ncurrencyName: \(self.currencyName!)\ncurrencySymbol: \(self.currencySymbol!)\n----------------------------"
    }
}
