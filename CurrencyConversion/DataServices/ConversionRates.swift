//
//  ConversionRates.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation


class ConversionRates {
    
    let apiKey = ""
    
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
    
    func fetchConversion(to:String, from:String, amount:Decimal) async -> Conversion? {
        guard let _ = buildRequest(to: to, from: from, amount: amount) else {
            return nil
        }
        do{
//            let (conversionData, _) = try  await URLSession.shared.data(for: request)
            let conversionData = Data(try mockData().utf8)
            let str = String(decoding: conversionData, as: UTF8.self)
            print(str)
            let result = JSONtoOBJ(json: conversionData)
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
}
