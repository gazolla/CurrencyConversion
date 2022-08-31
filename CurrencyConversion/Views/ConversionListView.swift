//
//  ConversionListView.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 29/08/22.
//

import SwiftUI

struct ConversionListView: View {
    @Binding var history:[History]
    var body: some View {
        List{
            Section(header: Text("History")) {
                ForEach(history){ item in
                   
                        VStack(alignment: .leading){
                            HStack{
                                Image(item.baseCurrency.countryCode ?? "")
                                    .clipShape(Circle())
                                Image(item.ratedCurrency.countryCode ?? "")
                                    .clipShape(Circle())
                                    .offset(x:-25)
                                Spacer()
                                Text("\(item.conversion.date ?? "Void")")
                                   .font(.caption.weight(.light))
                                   .padding(8)
                                   .background{
                                       RoundedRectangle(cornerRadius: 25)
                                           .fill(Color.gray.opacity(0.4))
                                   }
                            }
                            HStack{
                                Text("\(item.conversion.base ?? "Void")")
                                    .font(.headline.weight(.light))
                                Text("/")
                                   .font(.headline.weight(.bold))
                                   .foregroundColor(.gray)
                                Text("\(item.conversion.rateKey)")
                                    .font(.headline.weight(.light))
                            }
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            
                            HStack{
                                Text(" \(item.baseCurrency.currencySymbol ?? "") 1.00")
                                    .font(.headline.weight(.bold))
                                Spacer()
                                Image(systemName: "arrow.forward")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(item.ratedCurrency.currencySymbol ?? "") \(item.conversion.rateValue)")
                                    .font(.headline.weight(.bold))
                            }
                            
        
                        }
                        
                        
                   
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
}

struct wrapper: View{
    @State var data = [
        History(conversion: Conversion(success: true, timestamp: 0, base: "USD", date: "2022-08-27", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"), baseCurrency: Currency(countryName:"United States", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$"), ratedCurrency: Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$")),
        History(conversion: Conversion(success: true, timestamp: 0, base: "USD", date: "2022-08-27", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"), baseCurrency: Currency(countryName:"United States", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$") ,ratedCurrency: Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$")),
        History(conversion: Conversion(success: true, timestamp: 0, base: "USD", date: "2022-08-27", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"), baseCurrency: Currency(countryName:"United States", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$"), ratedCurrency: Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$")),
        History(conversion: Conversion(success: true, timestamp: 0, base: "USD", date: "2022-08-27", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"), baseCurrency: Currency(countryName:"United States", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$") ,ratedCurrency: Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$")),
        History(conversion: Conversion(success: true, timestamp: 0, base: "USD", date: "2022-08-27", rates: ["BRL" : 5.0232], baseCountryCode: "US", ratedCountryCode: "BR"), baseCurrency: Currency(countryName:"United States", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$"), ratedCurrency: Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$"))
    ]
    var body: some View {
        ConversionListView(history: $data)
    }
}


struct ConversionListView_Previews: PreviewProvider {
    static var previews: some View {
        wrapper()
    }
}
