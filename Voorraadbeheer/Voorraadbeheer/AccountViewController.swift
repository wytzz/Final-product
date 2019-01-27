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
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
        print(product)
        emailLabel.text! = loginuser!
        productCountLabel.text! = String(product.count)
    }
    
    func updateUI(with product: [products]) {
        DispatchQueue.main.async {
            self.product = product

}
}
}
