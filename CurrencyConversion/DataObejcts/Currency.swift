//
//  Currency.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation

struct Currency:Identifiable {
    var id = UUID()
    
    var countryName:String?
    var countryCode:String?
    var currencyCode:String?
    var currencyName:String?
    var currencySymbol:String?
 }

extension Currency:CustomStringConvertible {
    var description: String {
        return "\nCountryCode   : \(self.countryCode!)\nName         : \(self.countryName!)\nCurrencyCode : \(self.currencyCode!)\ncurrencyName: \(self.currencyName!)\ncurrencySymbol: \(self.currencySymbol!)\n----------------------------"
    }
}
