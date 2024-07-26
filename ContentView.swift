//
//  ContentView.swift
//  Habit-Bank
//
//  Created by Michael Roberson on 7/25/24.
//
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    @StateObject private var firestoreService = FirestoreService()

    var body: some View {
        VStack {
            Text("Habit Bank")
                .font(.largeTitle)

            Button("Add User") {
                let user = UserModel(name: "New User", email: "user@example.com")
                firestoreService.addUser(user) { result in
                    switch result {
                    case .success():
                        print("User added successfully")
                    case .failure(let error):
                        print("Failed to add user: \(error.localizedDescription)")
                    }
                }
            }

            Button("Fetch Users") {
                firestoreService.fetchUsers { result in
                    switch result {
                    case .success(let users):
                        print("Fetched users: \(users)")
                    case .failure(let error):
                        print("Failed to fetch users: \(error.localizedDescription)")
                    }
                }
            }

            Button("Update User") {
                let user = UserModel(id: "existingUserId", name: "Updated User", email: "updated@example.com")
                firestoreService.updateUser(user) { result in
                    switch result {
                    case .success():
                        print("User updated successfully")
                    case .failure(let error):
                        print("Failed to update user: \(error.localizedDescription)")
                    }
                }
            }

            Button("Delete User") {
                let user = UserModel(id: "existingUserId", name: "User to Delete", email: "delete@example.com")
                firestoreService.deleteUser(user) { result in
                    switch result {
                    case .success():
                        print("User deleted successfully")
                    case .failure(let error):
                        print("Failed to delete user: \(error.localizedDescription)")
                    }
                }
            }
        }
        .padding()
    }
}

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
}
