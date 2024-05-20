//
//  FormView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import SwiftUI

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @State var titleText = ""
    @ObservedObject private var viewModel = QuoteViewModel()


    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("add quote here:")) {
                    TextEditor(text: $titleText)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle("Add Quote")
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.viewModel.postDataToFirestore(title: titleText)
                        titleText = ""
                        dismiss()
                    }) {
                        Text("Save")
                    }
                    .disabled(self.titleText.isEmpty)
                }
            }
        }
    }
}

#Preview {
    FormView()
}
