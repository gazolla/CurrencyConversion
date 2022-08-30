//
//  ConversionRates.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation


class ConversionRates {
    
    static let instance = ConversionRates()
    private init(){}
    
    let apiKey = "1KpzbD4bZdUNBDf214M6ao1S4gD7BGGX"
    var lastMessage:Message?
    var conversionsHistory:[Conversion] = []
    
    func buildRequest(to:String, from:String, amount:Decimal)->URLRequest?{
        var uc = URLComponents()
        uc.scheme = "https"
        uc.host = "api.apilayer.com"
        uc.path = "/fixer/latest"
        uc.queryItems = [
            URLQueryItem(name: "base", value: from),
            URLQueryItem(name: "symbols", value: to)
        ]
        if let url = uc.url {
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue(apiKey, forHTTPHeaderField: "apikey")
            return request
        }
        return nil
    }
    
    func JSONtoOBJ(json:Data)->Conversion?{
        do{
            let decode = JSONDecoder()
            let result = try decode.decode(Conversion.self, from: json)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func JSONtoMSG(json:Data)->Message?{
        do{
            let decode = JSONDecoder()
            let result = try decode.decode(Message.self, from: json)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchConversion(to:Currency, from:Currency, amount:Decimal) async -> Conversion? {
        guard let request = buildRequest(to: to.currencyCode!, from: from.currencyCode!, amount: amount) else {
            return nil
        }
        do{
            let (conversionData, _) = try  await URLSession.shared.data(for: request)
        //    let conversionData = Data(try mockData().utf8)
            let str = String(decoding: conversionData, as: UTF8.self)
            print(str)
            if str.contains("message"){
                self.lastMessage = JSONtoMSG(json: conversionData)
            } else {
                var result = JSONtoOBJ(json: conversionData)
                result?.baseCountryCode = from.currencyCode
                result?.ratedCountryCode = to.currencyCode
                return result
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func mockData() throws -> String  {
        let result = """
                {
                    "success": true,
                    "timestamp": 1661627224,
                    "base": "USD",
                    "date": "2022-08-27",
                    "rates": {
                        "BRL": 5.063122
                    }
                }
                """
        return result
    }
    
    func loadConversions() throws{
        if let data = UserDefaults.standard.data(forKey: "conversions"){
            let decoder = JSONDecoder()
            self.conversionsHistory = try decoder.decode([Conversion].self, from:data)
        }
    }
    
    func saveConversions() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self.conversionsHistory.isEmpty ? [Conversion](): self.conversionsHistory)
        UserDefaults.standard.set(data, forKey: "conversions")
    }
    
    func addConversion(conversion:Conversion){
        self.conversionsHistory.append(conversion)
    }
    
    func deleteConversion(at indexSet:IndexSet){
        self.conversionsHistory.remove(atOffsets: indexSet)
    }
}
