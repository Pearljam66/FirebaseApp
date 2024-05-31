//
//  AuthViewModel.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/23/24.
//

import FirebaseAuth
import SwiftUI

final class AuthViewModel: ObservableObject {
    @Published var user: User?

    func authStateListener() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard self != nil else { return }
        }
        self.user = user
    }

    func signIn(emailAddress: String, password: String) {
        Auth.auth().signIn(withEmail: emailAddress, password: password)
    }

    func createAnAccount(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func resetPassword(emailAddress: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress)
    }

}
