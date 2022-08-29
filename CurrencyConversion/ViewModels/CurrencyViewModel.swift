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
    var cancellables = Set<AnyCancellable>()
    
    let currencyService = CurrencyDataService.instance
    
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
}
