//
//  AuthController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthController{
    
    private static let db = Firestore.firestore()
    
    // This is my Register the user function
    
    static func registerUser(email: String, password: String, username: String, completion: @escaping (Bool, Error?)-> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            // save the automatically generated user id to a var
            
            guard let uid = authResult?.user.uid else {
                completion(false, error)
                return
            }
            // Saves user Display name in FireStore using User ID VAR
            
            db.collection("users").document(uid).setData([
                "username": username,
                "email": email]){
                    error in
                    if let error = error {
                        completion(false, error)
                    } else {
                        completion(true, nil)
                    }
                }
        }
        
    }
    
    // This is my Sign In Function
    static func signInUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    // This is my Sign Out Function
    static func signOutUser(completion: @escaping (Bool, Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch {
            print(error)
            completion(false, error)
        }
    }
}
