//
//  MockFirestoreDatabase.swift
//  FirebaseAppTests
//
//  Created by Sarah Clark on 5/23/24.
//

import Foundation
import FirebaseFirestore

class MockFirestoreDatabase {
    var addDocumentCallCount = 0
    var updateDocumentCallCount = 0
    var deleteDocumentCallCount = 0
    var addSnapshotListenerCallCount = 0

    var addDocumentHandler: (([String: Any], @escaping (Error?) -> Void) -> Void)?
    var updateDocumentHandler: ((String, [String: Any], @escaping (Error?) -> Void) -> Void)?
    var deleteDocumentHandler: ((String, @escaping (Error?) -> Void) -> Void)?
    var addSnapshotListenerHandler: ((@escaping ([QueryDocumentSnapshot]?, Error?) -> Void) -> Void)?

    @objc func addDocument(data: [String: Any], completion: @escaping (Error?) -> Void) {
        addDocumentCallCount += 1
        addDocumentHandler?(data, completion)
    }

    @objc func updateDocument(id: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        updateDocumentCallCount += 1
        updateDocumentHandler?(id, data, completion)
    }

    @objc func deleteDocument(id: String, completion: @escaping (Error?) -> Void) {
        deleteDocumentCallCount += 1
        deleteDocumentHandler?(id, completion)
    }

    @objc func addSnapshotListener(completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        addSnapshotListenerCallCount += 1
        addSnapshotListenerHandler?(completion)
    }
}


extension Firestore {
    static var isSwizzled = false

    static func swizzleFirestoreMethods(with mock: MockFirestoreDatabase) {
        guard !isSwizzled else { return }

        let originalAddDocument = class_getInstanceMethod(CollectionReference.self, #selector(CollectionReference.addDocument(data:completion:)))
        let mockAddDocument = class_getInstanceMethod(MockFirestoreDatabase.self, #selector(MockFirestoreDatabase.addDocument(data:completion:)))
        method_exchangeImplementations(originalAddDocument!, mockAddDocument!)

        let originalUpdateDocument = class_getInstanceMethod(DocumentReference.self, #selector(DocumentReference.updateData(_:completion:)))
        let mockUpdateDocument = class_getInstanceMethod(MockFirestoreDatabase.self, #selector(MockFirestoreDatabase.updateDocument(id:data:completion:)))
        method_exchangeImplementations(originalUpdateDocument!, mockUpdateDocument!)

        let originalDeleteDocument = class_getInstanceMethod(DocumentReference.self, #selector(DocumentReference.delete(completion:)))
        let mockDeleteDocument = class_getInstanceMethod(MockFirestoreDatabase.self, #selector(MockFirestoreDatabase.deleteDocument(id:completion:)))
        method_exchangeImplementations(originalDeleteDocument!, mockDeleteDocument!)

        let originalAddSnapshotListener = class_getInstanceMethod(CollectionReference.self, #selector(CollectionReference.addSnapshotListener(_:)))
        let mockAddSnapshotListener = class_getInstanceMethod(MockFirestoreDatabase.self, #selector(MockFirestoreDatabase.addSnapshotListener(completion:)))
        method_exchangeImplementations(originalAddSnapshotListener!, mockAddSnapshotListener!)

        isSwizzled = true
    }
}

