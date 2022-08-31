//
//  CurrencySearchView.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 28/08/22.
//

import SwiftUI

struct CurrencySearchView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var cvm = CurrencyViewModel.instance
    @State var searchQuery = ""
    @State var setCurrency:((Currency)->())
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(cvm.CurrencyData){ currency in
                    Button {
                        setCurrency(currency)
                        dismiss()
                    } label: {
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
            }
            .navigationTitle("Currencies")
        }
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { newValue in
            cvm.filterCurrency(searchQuery: newValue)
        }
        .onAppear{
            cvm.filterCurrency(searchQuery:"")
        }
    }

}

struct CurrencySearchView_Previews: PreviewProvider {
    func setCurrency(currency:Currency){
        
    }
    static var previews: some View {
        CurrencySearchView { _ in }
    }
}
