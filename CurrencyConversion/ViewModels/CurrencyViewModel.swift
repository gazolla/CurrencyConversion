//
//  CurrencyViewModel.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation
import Combine

class CurrencyViewModel: ObservableObject {
    
    @Published var CurrencyData:[Currency] = []
    @Published var conversion:Conversion?
    @Published var message:Message?

    var cancellables = Set<AnyCancellable>()
    
    let currencyService = CurrencyDataService.instance
    let conversionService = ConversionRates.instance
    
    init(){
        filterCurrency(searchQuery: "")
    }
    
    func filterCurrency(searchQuery:String){
        currencyService.$currencies
            .sink { [weak self] (returnedCurrencies) in
                if searchQuery.isEmpty {
                    self?.CurrencyData = returnedCurrencies
                } else {
                    self?.CurrencyData = returnedCurrencies.filter {
                        $0.currencyName!
                            .localizedCaseInsensitiveContains(searchQuery)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func conversion(from:Currency, to:Currency) async {
        if let conversion = await conversionService.fetchConversion(to:to, from:from, amount: 0.00) {
            self.conversion = conversion
        } else {
            self.message = conversionService.lastMessage
            conversionService.lastMessage = nil
        }
    }
    
    func clearResult(){
        self.conversion = nil
    }
}
