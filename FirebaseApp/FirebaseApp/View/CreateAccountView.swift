//
//  CreateAccountView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/31/24.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) var dismiss
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email address", text: $emailAddress)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("Password - Must be 6 characters or more", text: $password)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
            }

            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button(action: {
                        authViewModel.createAnAccount(emailAddress: emailAddress, password: password)
                    }) {
                        Text("Done").bold()
                    }
                }
                ToolbarItem (placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Create Account")
        }
    }
}

#Preview {
    CreateAccountView()
}
