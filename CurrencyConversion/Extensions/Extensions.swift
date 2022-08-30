//
//  Extensions.swift
//  CurrencyConversion
//
//  Created by sebastiao Gazolla Costa Junior on 29/08/22.
//

import SwiftUI

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

extension StringProtocol { // for Swift 4 you need to add the constrain `where Index == String.Index`
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
