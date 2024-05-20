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

    var body: some View {
        NavigationStack {
            List {

            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Text(" notes")
                    Spacer()
                    Button {
                        displaySheet.toggle()
                    } label: {
                        Image(systemName: "pencil.circle")
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
