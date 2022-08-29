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
struct Conversion:Codable {
    var success:Bool?
    var timestamp:Int?
    var base:String?
    var date:String?
    var rates:[String:Decimal]?
}


extension Conversion: CustomStringConvertible {
    var description: String {
        return "~ 1 \(base ?? "void")  =  \(rates?.first?.value ?? 0.00) \(rates?.first?.key ?? "void")"
    }
}

struct Message:Codable {
    var message:String?
}
