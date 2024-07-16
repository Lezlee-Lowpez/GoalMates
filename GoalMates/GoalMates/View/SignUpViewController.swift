//
//  SignUpViewController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/3/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var emailSignUpLabel: UITextField!
    
    @IBOutlet weak var passwordSignUpLabel: UITextField!
    
    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let email = emailSignUpLabel.text, !email.isEmpty, let password = passwordSignUpLabel.text, !password.isEmpty, let userName = userNameLabel.text, !userName.isEmpty else {
            showAlert(withTitle: "Missing Info", message: "Please fill out all fields.")
            return
        }
   
        
        AuthController.registerUser(email: email, password: password, username: userName) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.showSuccessAlert(withTitle: "User registered", message: "User was registered.")
                    
                }else {
                    self?.showAlert(withTitle: "Registration Error", message: error?.localizedDescription ?? "There was an unexpected error.")
                }
            }
        }
   
        
    }

    private func showSuccessAlert(withTitle title: String, message: String ){
        let alert = UIAlertController(title: "Success", message: "User was registered successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            // Pop to the root view controller after the alert is dismissed
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
