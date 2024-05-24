//
//  AuthDecisionView.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/23/24.
//

import SwiftUI

struct AuthDecisionView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if authViewModel.user == nil {
                LoginView()
            } else {
                ContentView()
            }
        }
        .onAppear {
            authViewModel.authStateListener()
        }
    }
}

#Preview {
    AuthDecisionView()
}
