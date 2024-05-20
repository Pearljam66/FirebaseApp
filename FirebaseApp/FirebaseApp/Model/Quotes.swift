//
//  Note.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseFirestoreSwift
import Foundation

struct Quotes: Codable {

    @DocumentID var id: String?
    var title: String?

}
