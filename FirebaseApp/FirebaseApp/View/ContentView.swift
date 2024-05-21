//
//  ContentView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var displaySheet = false
    @State private var postDetent = PresentationDetent.medium
    @ObservedObject private var viewModel = QuoteViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(viewModel.quotes.enumerated()), id: \.element.id) { index, quote in
                    NavigationLink(destination: QuoteDetailView(quote: quote)) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("\(index + 1).")
                                    .font(.system(size: 22, weight: .bold))
                                Text(quote.title ?? "")
                                    .font(.system(size: 22, weight: .regular))
                            }
                        }
                        .frame(maxHeight: 200)
                    }
                }
            }
            .onAppear(perform: self.viewModel.readDataFromFirestore)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Text("\(viewModel.quotes.count) quotes")
                    Spacer()
                    Button {
                        displaySheet.toggle()
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                    }
                    .imageScale(.large)
                    .sheet(isPresented: $displaySheet) {
                        FormView().presentationDetents([.large, .medium])
                    }
                }
            }
            .navigationTitle("Quotes")
        }
    }
}

#Preview {
    ContentView()
}
