//
//  QuoteDetailView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import SwiftUI

struct QuoteDetailView: View {
    var quote: Quote

    @State private var presentAlert = false
    @State private var titleText: String = ""
    @ObservedObject private var viewModel = QuoteViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(quote.title ?? "No quote.")
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    Spacer()
                }
            }

        }
        .navigationTitle("Quote Details")
            .toolbar {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button {
                        presentAlert = true
                    } label: {
                        Text("Edit").bold()
                    }
                    .alert("Quote", isPresented: $presentAlert, actions: {
                        TextField("\(quote.title ?? "")", text: $titleText)
                        Button("Save", action: {
                            self.viewModel.editDataInFirestore(title: titleText, id: quote.id ?? "")
                            titleText = ""
                        })
                        Button("Cancel", role: .cancel, action: {
                            presentAlert = false
                            titleText = ""
                        })
                    }, message: {
                        Text("Change your quote.")
                    })
                }
            }
    }
}

#Preview {
    QuoteDetailView(quote: Quote(id: "1MDRtCKGZ9ZosZX05fBt", title: "The only place where success comes before work is in the dictionary."))
}
