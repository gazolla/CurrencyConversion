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
    @State private var isSearching = false
    @State private var isShowMessage = false
    
    @StateObject private var cvm = CurrencyViewModel.instance
    
    @State private var toCurrency:Currency?
    @State private var fromCurrency:Currency?
    
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)),Color( #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height:UIScreen.main.bounds.height * 0.5)
                Spacer()
            }
            .ignoresSafeArea()
                
            VStack{
                showBasicTopView {
                    showCurrencies
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
                        .navigationBarTitle("Currency Conversion", displayMode: .inline)
                        .navigationBarItems(leading: isSearching ? ProgressView().foregroundColor(.black) : nil, trailing: Button(action: {
                             toCurrency = nil
                             fromCurrency = nil
                             cvm.clearResult()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                        }))
                }
                .padding()
                if let conversion = cvm.conversion {
                    conversionView(conversion: conversion)
                } else if isShowMessage {
                    if let message = cvm.message {
                        Spacer()
                        showMessage(message: message)
                    }
                } else {
                    showSearchButton
                }
                Spacer()
                
                ConversionListView(cvm: cvm)
                
            }
            
            .onAppear{
                cvm.loadConversions()
                print("load history")
            }
            .onChange(of: cvm.conversionHistory) { _ in
                cvm.saveConversions()
                print("save history")
            }
        }
        .embedInNavigationView()
    }
}

enum SelectSearchCurrency {
    case from
    case to
    case idle
}


extension ContentView {
    
    var showSearchButton: some View {
        showBasicTopView {
            Text(isSearching ? "Searching..." : "Search")
                .font(.title).fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            
        }
        .padding()
        .asButton {
            Task{
                if let fromCurrency, let toCurrency {
                    isSearching = true
                    await cvm.conversion(from: fromCurrency, to: toCurrency)
                    if let _ = cvm.message {
                        DispatchQueue.main.async {
                            withAnimation(.spring()) {
                                isShowMessage = true
                            }
                        }
                    }
                    isSearching = false
                }
            }
        }
        .disabled((fromCurrency == nil || toCurrency == nil) ? true : false)
    }
    
    var showCurrencies:some View{
        VStack{
            currencyView(text: "from: ", currency: fromCurrency)
                .asButton {
                    selectSearchCurrency = .from
                    isShowingSearchCurrency.toggle()
                    cvm.clearResult()
                }
            currencyView(text: "to: ", currency: toCurrency)
                .asButton {
                    selectSearchCurrency = .to
                    isShowingSearchCurrency.toggle()
                    cvm.clearResult()
                }
        }
    }
    
    @ViewBuilder func showMessage(message:Message) -> some View {
        VStack(){
            Spacer()
            RoundedRectangle(cornerRadius:20)
                .fill(.thinMaterial)
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .overlay{
                    ZStack{
                        Button(action: {
                            withAnimation(.spring()) {
                                isShowMessage = false
                                cvm.message = nil
                            }
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity,  alignment: .trailing)
                                .frame(maxHeight: .infinity, alignment: .top)
                                .padding(20)
                        }
                        VStack(alignment: .center){
                            Text("Error")
                                .font(.title).fontWeight(.bold)
                            Text("\(message.message!)")
                                .font(.headline).fontWeight(.light)
                        }
                    }
                }
        }
        .transition(.move(edge: .bottom))
    }
    
    @ViewBuilder func currencyView(text:String, currency:Currency?) -> some View{
        HStack{
            Text("\(text)")
                .font(.headline).fontWeight(.bold)
                .frame(width: 60)
            showBasicTopView {
                HStack{
                    if let currency {
                        Image(currency.countryCode!)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        VStack(alignment:.leading){
                            Text("\(currency.currencyCode!) - \(currency.currencyShortName!)")
                            Text(currency.countryName ?? "")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    } else {
                        Image("empty")
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        VStack(alignment:.leading){
                            Text("Select a currency")
                            Text("Tap here")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
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
    
    @ViewBuilder func showMainView(subViews:(()->some View))-> some View{
        VStack(spacing: 0) {
            VStack{
                subViews()
            }
            .background(.clear)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:15)
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
