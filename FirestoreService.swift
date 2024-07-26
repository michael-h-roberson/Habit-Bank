//
//  FirestoreService.swift
//  Habit-Bank
//
//  Created by Michael Roberson on 7/25/24.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    private let usersCollection = "users"

    func addUser(_ user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection(usersCollection).addDocument(from: user, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    func fetchUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        db.collection(usersCollection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let users = snapshot.documents.compactMap { document -> UserModel? in
                    try? document.data(as: UserModel.self)
                }
                completion(.success(users))
            }
        }
    }

    func updateUser(_ user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = user.id else { return }
        do {
            try db.collection(usersCollection).document(id).setData(from: user, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch let error {
            completion(.failure(error))
        }
    }

    func deleteUser(_ user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = user.id else { return }
        db.collection(usersCollection).document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
