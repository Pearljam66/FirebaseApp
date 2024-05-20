//
//  Note.swift
//  FirebaseApp
//
//  Created by Sarah Clark on 5/20/24.
//

import FirebaseFirestoreSwift
import Foundation

struct Note: Codable {

    @DocumentID var id: String?
    var title: String?

}
