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
    @ObservedObject private var viewModel = NoteViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes, id:\.id) { note in
                    VStack(alignment: .leading) {
                        Text(note.title ?? "")
                            .font(.system(size: 22, weight: .regular))
                    }
                    .frame(maxHeight: 200)
                }
            }
            .onAppear(perform: self.viewModel.readDataFromFirestore)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Text("\(viewModel.notes.count) notes")
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
            .navigationTitle("Notes")
        }
    }
}

#Preview {
    ContentView()
}
