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
    @ObservedObject private var viewModel = NoteViewModel()


    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Titles")) {
                    TextEditor(text: $titleText)
                        .frame(minHeight: 200)
                }

                Section {
                    Button(action: {
                        self.viewModel.postDataToFirestore(title: titleText)
                        titleText = ""
                        dismiss()
                    }) {
                        Text("Save")
                    }
                    .disabled(self.titleText.isEmpty)
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Publish")
            .toolbar {
                ToolbarItemGroup(placement: .destructiveAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FormView()
}
