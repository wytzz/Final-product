//
//  ViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 10/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
import FirebaseAuth

//extension to set one white bottomborder in textfield
extension UITextField {
    //layout for textfields in login and sign in pages
    func setBottomborder() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    //adds options to change layout in storyboard for textfields
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
    
}

//adds options to change layout in storyboard for textfields

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    //adds options to change layout in storyboard for textfields

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    //adds options to change layout in storyboard for textfields

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
        hideKeyboardWhenTappedAround()
        emailTextfield.setBottomborder()
        PasswordTextfield.setBottomborder()
        self.view.backgroundColor = UIColor(red: 0 , green: 0.01, blue: 0.45, alpha: 1.0)// #000273
    }
    //when loginbuttonispressed
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: PasswordTextfield.text!) { (user, error) in
            //login if textfields are filled in and correct
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: nil)
            } else {
                //give the error(textfield isn't filled in or wrong email or password) in an alert
                if let myError = error?.localizedDescription {
                    let erroralert = UIAlertController(title: "There was a problem", message: myError , preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                    erroralert.addAction(okButton)
                    self.present(erroralert, animated: true, completion: nil)
                }
            }
        }
    }
    //set statusbar to white text
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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

