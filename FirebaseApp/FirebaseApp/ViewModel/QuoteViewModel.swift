//
//  QuoteViewModel.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseFirestore

class QuoteViewModel: ObservableObject {

    @Published var quotes = [Quote]()
    private var firestoreDatabase = Firestore.firestore().collection("Quotes")

    func postDataToFirestore(title: String) {
        firestoreDatabase.addDocument(data: ["title": title]) { error in
            if let error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully.")
            }
        }
    }

    func readDataFromFirestore() {
        firestoreDatabase.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There are not documents.")
                return
            }

            self.quotes = documents.compactMap { queryDocumentSnapshot -> Quote? in
                return try? queryDocumentSnapshot.data(as: Quote.self)
            }
        }
    }

    func editDataInFirestore(title: String, id: String) {
        firestoreDatabase.document(id).updateData(["title" : title]) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Quote updated successfully.")
            }
        }
    }

}
