//
//  ContentView.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Spacer()
            }
            .padding()
            .navigationTitle("Currency Conversion")
        }
        
    }
    
    @ViewBuilder func currencyView(currency:Currency) -> some View{
        HStack{
            Image(currency.countryCode!)
            VStack(alignment:.leading){
                Text("\(currency.currencyCode!) - \(currency.currencyName!)")
                Text(currency.countryName ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
