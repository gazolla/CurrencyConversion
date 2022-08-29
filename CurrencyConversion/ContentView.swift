//
//  ContentView.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import SwiftUI

struct ContentView: View {
    
     
    @State private var selectSearchCurrency: SelectSearchCurrency = .idle
    @State private var isShowingSearchCurrency = false

    @State private var toCurrency = Currency(countryName: "Brazil", countryCode: "BR", currencyCode: "BRL", currencyName: "Real", currencySymbol: "R$")
    @State private var fromCurrency = Currency(countryName: "USA", countryCode: "US", currencyCode: "USD", currencyName: "Dollar", currencySymbol: "US$")
    @State  private var conversion = ConversionRates().JSONtoOBJ(json: Data(try! ConversionRates().mockData().utf8))
    
    var body: some View {
        VStack{
            showBasicTopView {
                VStack{
                    currencyView(text: "from: ", currency: fromCurrency)
                        .asButton {
                            selectSearchCurrency = .from
                            isShowingSearchCurrency.toggle()
                        }
                    currencyView(text: "to: ", currency: toCurrency)
                        .asButton {
                            selectSearchCurrency = .to
                            isShowingSearchCurrency.toggle()
                        }
                }
                .sheet(isPresented: $isShowingSearchCurrency, content: {
                   
                    if selectSearchCurrency == .from{
                        CurrencySearchView { from in
                            self.fromCurrency = from
                        }
                    } else if selectSearchCurrency == .to{
                        CurrencySearchView { to in
                            self.toCurrency = to
                        }
                    }
                    
                })
                .padding()
                .onChange(of: selectSearchCurrency) { newValue in
                    print("ssc: \(newValue)")
                }
                
            }
            .padding()
            conversionView(conversion: conversion!)
                .navigationBarTitle("Currency Conversion", displayMode: .inline)
                
            Spacer()
        }.embedInNavigationView()
    }
}

enum SelectSearchCurrency {
    case from
    case to
    case idle
}


extension ContentView {

    @ViewBuilder func currencyView(text:String, currency:Currency) -> some View{
        HStack{
            Text("\(text)")
                .font(.headline).fontWeight(.bold)
                .frame(width: 60)
            showBasicTopView {
                HStack{
                    Image(currency.countryCode!)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    VStack(alignment:.leading){
                        Text("\(currency.currencyCode!) - \(currency.currencyName!)")
                        Text(currency.countryName ?? "")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .frame(maxWidth:.infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder func conversionView(conversion:Conversion) -> some View{
        showBasicTopView {
            Text("\(conversion.description)")
                .font(.title).fontWeight(.thin)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                
        }
        .padding()
    }
    
    @ViewBuilder func showBasicTopView(subViews:(()->some View))-> some View{
        VStack(spacing: 0) {
           VStack{
               subViews()
           }
           .background(.thickMaterial)
           .cornerRadius(10)
           .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:15)
       }
    }
}

extension View{
    func embedInNavigationView() -> some View{
        NavigationView {
            self
        }
    }
    
    func asButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
