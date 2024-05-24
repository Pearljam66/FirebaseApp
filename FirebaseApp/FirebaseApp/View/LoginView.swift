//
//  LoginView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/23/24.
//

import SwiftUI

struct LoginView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {

            Form {
                TextField("Email address", text: $emailAddress)
                    .autocorrectionDisabled(true)
                SecureField("Password", text: $password)
                    .autocorrectionDisabled(true)
            }

            .toolbar {
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button(action: {
                        // Log in to Firebase
                    }) {
                        Text("Sign In")
                    }
                }
            }
            .navigationTitle("Welcome")
        }

    }
}

#Preview {
    LoginView()
}
