//
//  AccountViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 14/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    var product : [products] = []
    var loginuser : String?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBAction func logOutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        catch {
            print("Couldn't log out")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(red: 0 , green: 0.01, blue: 0.45, alpha: 1.0) // #000273
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
        //shows email
        emailLabel.text! = loginuser!
    }
    
    //set statusbar to white text
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func updateUI(with product: [products]) {
        DispatchQueue.main.async {
            self.product = product
            //show how many products you have
            self.productCountLabel.text! = String(product.count)
        }
    }
}
