//
//  CurencyDataService.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation

class CurrencyDataService {
    static let instance = CurrencyDataService()
    
    @Published var currencies:[Currency] = []
    
    private init(){
        loadEveryCountryWithCurrency()
    }
    
    func loadEveryCountryWithCurrency() {
    
        let localeCurrencies = Locale.commonISOCurrencyCodes
        for currencyCode in localeCurrencies {
            
            let currency = Currency()
            currency.currencyCode = currencyCode
            
            let currencyLocale = Locale(identifier: currencyCode)
            currency.currencyName = (currencyLocale as NSLocale).displayName(forKey:NSLocale.Key.currencyCode, value: currencyCode)
            currency.countryCode = String(currencyCode.prefix(2))
            currency.currencySymbol = (currencyLocale as NSLocale).displayName(forKey:NSLocale.Key.currencySymbol, value: currencyCode)

            
            let countryLocale  = NSLocale.current
            currency.countryName = (countryLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: currency.countryCode!)
            
            
            if currency.countryName != nil {
                self.currencies.append(currency)
            }
            
        }
    
    }

}
