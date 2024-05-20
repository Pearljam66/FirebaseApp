//
//  NoteViewModel.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseFirestore

class NoteViewModel: ObservableObject {

    @Published var notes = [Note]()
    private var firestoreDatabase = Firestore.firestore().collection("Notes")

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

            self.notes = documents.compactMap { queryDocumentSnapshot -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
            }
        }
    }

}
