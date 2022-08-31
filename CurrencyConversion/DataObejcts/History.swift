//
//  History.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 30/08/22.
//

import Foundation

struct History:Identifiable, Codable, Equatable{
    var id = UUID()

    var conversion:Conversion
    var baseCurrency:Currency
    var ratedCurrency:Currency
    
    init(conversion: Conversion, baseCurrency: Currency, ratedCurrency: Currency) {
        self.conversion = conversion
        self.baseCurrency = baseCurrency
        self.ratedCurrency = ratedCurrency
    }
    
    private enum codingKeys: String, CodingKey {
        case conversion, baseCurrency, ratedCurrency
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        conversion = try container.decode(Conversion.self, forKey:.conversion)
        baseCurrency = try container.decode(Currency.self, forKey:.baseCurrency)
        ratedCurrency = try container.decode(Currency.self, forKey: .ratedCurrency)
    }
    
    static func == (lhs: History, rhs: History) -> Bool {
        lhs.id == rhs.id
    }

}
