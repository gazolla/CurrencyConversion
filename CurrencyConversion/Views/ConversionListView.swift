//
//  ConversionListView.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 29/08/22.
//

import SwiftUI

struct ConversionListView: View {
    @State var dataModel:[Conversion] = [
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"),
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"),
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"),
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"),
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"),
        Conversion(success: true, timestamp: 0, base: "USD", date: "12323", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR")
    ]
    var body: some View {
        List{
            Section(header: Text("History")) {
                ForEach(dataModel){ conversion in
                   
                        VStack(alignment: .leading){
                            HStack{
                                Image(conversion.baseCountryCode!)
                                    .clipShape(Circle())
                                
                                Image(conversion.ratedCountryCode!)
                                    .clipShape(Circle())
                                    .offset(x:-25)
                                
                            }
                            HStack{
                                 Text("\(conversion.base ?? "Void")")
                                    .font(.headline.weight(.light))
                                Text("/")
                                   .font(.headline.weight(.bold))
                                   .foregroundColor(.gray)
                                Text("\(conversion.rateKey)")
                                    .font(.headline.weight(.light))
                            }
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            
                            HStack{
                                 Text("1 \(conversion.base ?? "Void")")
                                    .font(.headline.weight(.bold))
                                Spacer()
                                Image(systemName: "arrow.forward")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(conversion.rateValue) \(conversion.rateKey)")
                                    .font(.headline.weight(.bold))
                            }
                            
        
                        }
                   
                }
            }
        }
    }
}


struct ConversionListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversionListView()
    }
}
