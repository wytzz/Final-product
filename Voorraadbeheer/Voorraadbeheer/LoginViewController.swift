//
//  ViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 10/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
import FirebaseAuth
extension UITextField {
    func setBottomborder() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.setBottomborder()
        PasswordTextfield.setBottomborder()
    }
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: PasswordTextfield.text!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
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

