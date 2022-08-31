//
//  CurrencyViewModel.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation
import Combine

class CurrencyViewModel: ObservableObject {
    
    static let instance = CurrencyViewModel()
    
    @Published var CurrencyData:[Currency] = []
    @Published var conversion:Conversion?
    @Published var message:Message?
    @Published var conversionHistory:[History] = []

    var cancellables = Set<AnyCancellable>()
    
    let currencyService = CurrencyDataService.instance
    let conversionService = ConversionRates.instance
    
    private init(){
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
        let (conversion, historyItem) = await conversionService.fetchConversion(to:to, from:from, amount: 0.00)
        if let conversion, let historyItem {
            self.conversion = conversion
            self.conversionHistory.append(historyItem)
            print("add history")
        } else {
            self.message = conversionService.lastMessage
            conversionService.lastMessage = nil
        }
    }
    
    func clearResult(){
        self.conversion = nil
    }
   
    
    func loadConversions() {
        do{
            if let data = UserDefaults.standard.data(forKey: "conversionHistory"){
                let decoder = JSONDecoder()
                self.conversionHistory = try decoder.decode([History].self, from:data)
            }
        } catch {
            print(error)
        }
    }
    
    func saveConversions() {
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.conversionHistory.isEmpty ? [History](): self.conversionHistory)
            UserDefaults.standard.set(data, forKey: "conversionHistory")

        } catch {
            print(error)
        }
    }

    
    func deleteConversion(at indexSet:IndexSet){
        conversionHistory.remove(atOffsets: indexSet)
    }
}
