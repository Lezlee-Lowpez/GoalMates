//
//  ViewController.swift
//  GoalMates
//
//  Created by Lesley Lopez on 5/1/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailLog: UITextField!
    @IBOutlet weak var userPasswordLog: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func signUpTouched(_ sender: UIButton) {
        let signUpVc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    
    // Login Button Action
    @IBAction func loginTouched(_ sender: UIButton) {
        guard let email = userEmailLog.text, let password = userPasswordLog.text else{
            showErrorAlert(message: "Please fill in all fields.")
            return
        }
        
        AuthController.signInUser(email: email, password: password) { success, error in
            if success{
//                print("User signed in")
                let profileVc = self.storyboard?.instantiateViewController(identifier: "UserProfileViewController") as! UserProfileViewController
                self.navigationController?.pushViewController(profileVc, animated: true)
                
            }else {
                self.showErrorAlert(message: "Incorrect email or password.")
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


