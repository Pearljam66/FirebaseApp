//
//  QuoteDetailView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import SwiftUI

struct QuoteDetailView: View {
    var quote: Quote

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("\(quote.title ?? "Nothing to see here.")")
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("Quote Details")
        }
    }
}

#Preview {
    QuoteDetailView(quote: Quote(id: "1MDRtCKGZ9ZosZX05fBt", title: "The only place where success comes before work is in the dictionary."))
}
