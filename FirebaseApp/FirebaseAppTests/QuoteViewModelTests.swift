//
//  QuoteViewModelTests.swift
//  FirebaseAppTests
//
//  Created by Sarah Clark on 5/23/24.
//

import XCTest
import FirebaseFirestore
@testable import FirebaseApp

final class QuoteViewModelTests: XCTestCase {

    var viewModel: QuoteViewModel!
    var mockFirestoreDatabase: MockFirestoreDatabase!

    override func setUp() {
        super.setUp()
        mockFirestoreDatabase = MockFirestoreDatabase()
        Firestore.swizzleFirestoreMethods(with: mockFirestoreDatabase)
        viewModel = QuoteViewModel()
    }

    override func tearDown() {
        viewModel = nil
        mockFirestoreDatabase = nil
        super.tearDown()
    }

    func testPostDataToFirestore() {
        let expectation = self.expectation(description: "Add Document")
        mockFirestoreDatabase.addDocumentHandler = { data, completion in
            XCTAssertEqual(data["title"] as? String, "Test Quote")
            completion(nil)
            expectation.fulfill()
        }

        viewModel.postDataToFirestore(title: "Test Quote")

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(mockFirestoreDatabase.addDocumentCallCount, 1, "addDocument should be called once")
    }

    func testReadDataFromFirestore() {
        let expectation = self.expectation(description: "Add Snapshot Listener")
        mockFirestoreDatabase.addSnapshotListenerHandler = { completion in
            completion([], nil)
            expectation.fulfill()
        }

        viewModel.readDataFromFirestore()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(mockFirestoreDatabase.addSnapshotListenerCallCount, 1, "addSnapshotListener should be called once")
    }

    func testEditDataInFirestore() {
        let expectation = self.expectation(description: "Update Document")
        let documentID = "testID"
        mockFirestoreDatabase.updateDocumentHandler = { id, data, completion in
            XCTAssertEqual(id, documentID)
            XCTAssertEqual(data["title"] as? String, "Updated Quote")
            completion(nil)
            expectation.fulfill()
        }

        viewModel.editDataInFirestore(title: "Updated Quote", id: documentID)

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(mockFirestoreDatabase.updateDocumentCallCount, 1, "updateDocument should be called once")
    }

    func testDeleteDataInFirestore() {
        let expectation = self.expectation(description: "Delete Document")
        let quote = Quote(id: "testID", title: "Test Quote")
        viewModel.quotes = [quote]

        mockFirestoreDatabase.deleteDocumentHandler = { id, completion in
            XCTAssertEqual(id, "testID")
            completion(nil)
            expectation.fulfill()
        }

        viewModel.deleteDataInFirestore(at: IndexSet(integer: 0))

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(mockFirestoreDatabase.deleteDocumentCallCount, 1, "deleteDocument should be called once")
    }
}
