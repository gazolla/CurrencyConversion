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
  "date": "2018-02-22",
  "historical": "",
  "info": {
    "rate": 148.972231,
    "timestamp": 1519328414
  },
  "query": {
    "amount": 25,
    "from": "GBP",
    "to": "JPY"
  },
  "result": 3724.305775,
  "success": true
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
        return "from:\(base ?? "void") to:\(rates?.first?.key ?? "void") value:\(rates?.first?.value ?? 0.00)"
    }
}

struct Message:Codable {
    var message:String?
}
