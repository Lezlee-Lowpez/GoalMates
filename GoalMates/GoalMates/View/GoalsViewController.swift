//
//  GoalsViewController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class GoalsViewController: UIViewController {
    
    var currentUsername: String?

    @IBOutlet weak var goalOneLabel: UITextField!
    @IBOutlet weak var goalTwoLabel: UITextField!
    @IBOutlet weak var goalThreeLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentUsername()
    }
    
    func fetchCurrentUsername(){
        FireStoreController.getCurrentUserName { [weak self] username, error in
            DispatchQueue.main.async {
                if let username = username {
                    self?.currentUsername = username
                    print("Got the username!")
                }else {
                    print("Something went wrong gettting username for firebase")
                }
            }
        }
    }
    

    @IBAction func submitGoalsBtn(_ sender: UIButton) {
        addGoalsToFireBase()
    }
 
    func addGoalsToFireBase(){
        guard let username = currentUsername else{
            print("No username available.")
            return
        }
        
        let goals = [goalOneLabel.text ?? "", goalTwoLabel.text ?? "", goalThreeLabel.text ?? ""].filter { !$0.isEmpty }
        guard !goals.isEmpty else {
            showErrorAlert(message: "Please enter at least one goal.")
            return
        }

        let goalPost = GoalPost(name: username, goals: goals)
        FireStoreController.addGoal(post: goalPost) { success, error in
           if success{
               let wasRegistered = UIAlertController(title: "Success", message: "Your Goals were posted!", preferredStyle: .alert)
               
               let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
                   self.dismiss(animated: true, completion: nil)
               }
               
               wasRegistered.addAction(okButton)
           
               self.present(wasRegistered, animated: true, completion: nil)
               
           }else{
               print("Something went wrong in calling the fireStoreClass in USer profile VC.")
           }
       }

        
    }
    func showSuccessAlert() {
         let alert = UIAlertController(title: "Success", message: "Your Goals were posted!", preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
             self?.dismiss(animated: true, completion: nil)
         }
         alert.addAction(okAction)
         present(alert, animated: true)
     }
     
     func showErrorAlert(message: String) {
         let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default)
         alert.addAction(okAction)
         present(alert, animated: true)
     }
 }
    

