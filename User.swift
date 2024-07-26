//
//  User.swift
//  Habit-Bank
//
//  Created by Michael Roberson on 7/25/24.
//

import Foundation

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var email: String
    var name: String
}
