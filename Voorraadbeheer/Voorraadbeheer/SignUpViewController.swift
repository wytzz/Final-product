//
//  SignUpViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 11/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var PasswordCheckTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTextfield.setBottomborder()
        PasswordTextfield.setBottomborder()
        PasswordCheckTextfield.setBottomborder()
        usernameTextfield.setBottomborder()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
