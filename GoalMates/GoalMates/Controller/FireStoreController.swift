//
//  FireStoreController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FireStoreController {
    // create reference to database
    private static let db = Firestore.firestore()
    
//     function for adding goal that takes in type GoalPost (it will be a completion)
    static func addGoal(post: GoalPost, completion: @escaping(Bool, Error?) -> Void) {
        let postData: [String: Any] = [
            "name": post.name,
            "goals": post.goals
        ]
        
        db.collection("goalPosts").addDocument(data : postData) { error in
            if let error = error{
                print("There was am errpr in your addGoal function: could not write to firebase!")
                completion(false, error)
            }else {
                print("Goal was written to your firebase!!")
                completion(true, nil)
            }
        }
        
    }
    
    static func getCurrentUserName(completion: @escaping (String?, Error?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in"]))
            return
        }
        
        
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists {
                let username = document.data()?["username"] as? String
                completion(username, nil)
            } else {
                completion(nil, NSError(domain: "FirestoreError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"]))
            }
        }
    }
    
    static func getAllGoalPost(completion: @escaping ([GoalPost], Error?) -> Void) {
        db.collection("goalPosts").getDocuments { snapshot, error in
            if let error = error{
                print("Error getting all posts")
                completion([], error)
            } else {
                var goalPosts = [GoalPost]()
                for document in snapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let goals = data["goals"] as? [String] ?? []
                    goalPosts.append(GoalPost(name: name, goals: goals))
                }
                completion(goalPosts, nil)
            }
        }
        
    }
    
    
    
}
