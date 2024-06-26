//
//  FirebaseAppApp.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct QuoteApp: App {

    // Register app delegate for Firebase setup.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AuthDecisionView().environmentObject(AuthViewModel())
        }
    }
}
