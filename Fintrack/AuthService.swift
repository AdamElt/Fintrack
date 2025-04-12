//
//  AuthService.swift
//  Fintrack
//
//  Created by Adam El-Telbani on 4/12/25.
//

import FirebaseAuth

class AuthService {
    static let shared = AuthService()

    private init() {}

    // Register a new user
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result))
            }
        })
    }

    // Log in an existing user
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(result))
            }
        })
    }
    
    func passwordReset(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // Log out
    func logout() throws {
        try Auth.auth().signOut()
    }

    // Check if user is signed in
    func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
