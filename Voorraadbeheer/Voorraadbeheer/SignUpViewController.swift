//
//  SignUpViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 11/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var PasswordCheckTextfield: UITextField!
    
    
    //sign in function/button pressed
    @IBAction func signUpButton(_ sender: UIButton) {
        //checks if password is the same as the repeated password and gives alert
        if PasswordTextfield.text != PasswordCheckTextfield.text {
            let alert = UIAlertController(title: "There was a problem", message: "There went something wrong with your password" , preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        } else { //continues if passwordcheck is ok
        Auth.auth().createUser(withEmail: EmailTextfield.text!, password: PasswordTextfield.text!) { (user, error) in
                if user != nil { // creates user
                    print("user Created!")
                    self.performSegue(withIdentifier: "gotologin", sender: self)
                } else { // error with password or email. It isn't a proper email or password is too short
                    if let myError = error?.localizedDescription {
                        let erroralert = UIAlertController(title: "There was a problem", message: myError , preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        erroralert.addAction(okButton)
                        self.present(erroralert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0 , green: 0.01, blue: 0.45, alpha: 1.0)// #000273
        EmailTextfield.setBottomborder()
        PasswordTextfield.setBottomborder()
        PasswordCheckTextfield.setBottomborder()
        hideKeyboardWhenTappedAround()
    }
    
    //set statusbar to white text
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
   
}
