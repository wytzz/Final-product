//
//  ViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 10/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
extension UITextField {
    func setBottomborder() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UsernameTextfield.setBottomborder()
        PasswordTextfield.setBottomborder()
    }
    


}

