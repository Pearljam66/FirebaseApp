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
    @State private var displaySheet = false
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {

            Form {
                Section {
                    TextField("Email address", text: $emailAddress)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .autocorrectionDisabled(true)
                    }

                Section {
                    HStack {
                        Text("Forgot password?")
                        Button {
                            displaySheet.toggle()
                        } label: {
                            Text("Reset Password").bold()
                        }
                        .sheet(isPresented: $displaySheet) {
                            RenamePasswordView()
                        }
                    }
                }

                    Section {
                        HStack {
                            Text("Don't have an account?")
                            Button(action: {
                                authViewModel.createAnAccount(emailAddress: emailAddress, password: password)
                            }) {
                                Text("Create Account").bold()
                            }
                        }
                    }
                }

                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button(action: {
                            authViewModel.signIn(emailAddress: emailAddress, password: password)
                        }) {
                            Text("Sign In")
                        }
                    }
                }
            .navigationTitle("Welcome to Quotes")

        }
    }
}

#Preview {
    LoginView()
}
