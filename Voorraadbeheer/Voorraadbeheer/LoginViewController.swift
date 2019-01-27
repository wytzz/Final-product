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
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
    
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
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
                self.performSegue(withIdentifier: "login", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let tabBarController = segue.destination as! UITabBarController
            let navigationController = tabBarController.viewControllers![0] as! UINavigationController
            let stockTableViewController = navigationController.topViewController as! StockTableViewController
            stockTableViewController.loginuser = emailTextfield.text!
            let accountViewController = tabBarController.viewControllers![1] as! AccountViewController
            accountViewController.loginuser = emailTextfield.text!
        }
    }

}

