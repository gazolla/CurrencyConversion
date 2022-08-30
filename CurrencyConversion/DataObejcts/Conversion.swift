//
//  Conversion.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import Foundation
/*
 Codable Object that maps the JSON below:
 {
     "success": true,
     "timestamp": 1661627224,
     "base": "USD",
     "date": "2022-08-27",
     "rates": {
         "BRL": 5.063122
     }
 }
*/
struct Conversion: Identifiable, Codable {
    var id = UUID()
    var success:Bool?
    var timestamp:Int?
    var base:String?
    var date:String?
    var rates:[String:Decimal]?
    
    var baseCountryCode:String?
    var ratedCountryCode:String?
    
    internal init(success: Bool? = nil, timestamp: Int? = nil, base: String? = nil, date: String? = nil, rates: [String : Decimal]? = nil, baseCountryCode:String? = nil, ratedCountryCode:String? = nil) {
        self.success = success
        self.timestamp = timestamp
        self.base = base
        self.date = date
        self.rates = rates
        self.baseCountryCode = baseCountryCode
        self.ratedCountryCode = ratedCountryCode
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: codingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        timestamp = try container.decode(Int.self, forKey:.timestamp)
        base = try container.decode(String.self, forKey:.base)
        date = try container.decode(String.self, forKey:.date)
        rates = try container.decode([String:Decimal].self, forKey:.rates)
    }
    
    private enum codingKeys: String, CodingKey {
        case success, timestamp, base, date, rates
    }
   
    var rateKey:String{
            return "\(rates?.first?.key ?? "Void")"
     }
    
    var rateValue:String{
        return "\(rates?.first?.value ?? 0.00)"
    }
}


extension Conversion: CustomStringConvertible {
    var description: String {
        return "~ 1 \(base ?? "void")  =  \(rates?.first?.value ?? 0.00) \(rates?.first?.key ?? "void")"
    }
}

struct Message:Codable {
    var message:String?
}
