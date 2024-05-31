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
    @State private var isPasswordVisible: Bool = false
    @State private var displayResetPasswordSheet = false
    @State private var displayCreateAccountSheet = false
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {

            Form {
                Section {
                    TextField("Email address", text: $emailAddress)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Password", text: $password)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }

                    }

                Section {
                    HStack {
                        Text("Forgot password?")
                        Button {
                            displayResetPasswordSheet.toggle()
                        } label: {
                            Text("Reset Password").bold()
                        }
                        .sheet(isPresented: $displayResetPasswordSheet) {
                            ResetPasswordView()
                        }
                    }
                }

                    Section {
                        HStack {
                            Text("Don't have an account?")
                            Button {
                                displayCreateAccountSheet.toggle()
                            } label: {
                                Text("Create Account").bold()
                            }
                            .sheet(isPresented: $displayCreateAccountSheet) {
                                CreateAccountView()
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
