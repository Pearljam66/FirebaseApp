//
//  QuoteViewModel.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseFirestore

class QuoteViewModel: ObservableObject {

    @Published var quotes = [Quotes]()
    private var firestoreDatabase = Firestore.firestore().collection("Quotes")

    func postDataToFirestore(title: String) {
        firestoreDatabase.addDocument(data: ["title": title]) { error in
            if let error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully")
            }
        }
    }

    func readDataFromFirestore() {
        firestoreDatabase.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There are not documents")
                return
            }

            self.quotes = documents.compactMap { queryDocumentSnapshot -> Quotes? in
                return try? queryDocumentSnapshot.data(as: Quotes.self)
            }
        }
    }

}
