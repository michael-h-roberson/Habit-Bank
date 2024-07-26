//
//  UserListView.swift
//  Habit-Bank
//
//  Created by Michael Roberson on 7/25/24.
//
import SwiftUI

struct UserListView: View {
    @ObservedObject var firestoreService: FirestoreService
    @State private var users: [UserModel] = []

    var body: some View {
        List(users) { user in
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            firestoreService.fetchUsers { result in
                switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                }
            }
        }
    }
}
