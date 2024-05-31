//
//  ForgotPasswordView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/30/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var emailAddress: String = ""
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                Section(footer: Text("Check your email to reset your password.")) {
                    Button(
                        action: {
                            authViewModel.resetPassword(emailAddress: emailAddress)
                        }) {
                            Text("Send email link").bold()
                        }
                }
            }
            .navigationTitle("Reset Password")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
