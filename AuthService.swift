//
//  AuthService.swift
//  Habit-Bank
//
//  Created by Michael Roberson on 7/25/24.
//
import FirebaseAuth

class AuthService: ObservableObject {
    @Published var user: FirebaseAuth.User?

    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.user = authResult?.user
                completion(.success(()))
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.user = authResult?.user
                completion(.success(()))
            }
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
        self.user = nil
    }
}

