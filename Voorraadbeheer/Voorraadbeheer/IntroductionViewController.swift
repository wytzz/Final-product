//
//  IntroductionViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 11/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0 , green: 0.01, blue: 0.45, alpha: 1.0)// #000273

        // Do any additional setup after loading the view.
    }
    //unwind from register or login page to introduction
    @IBAction func unwindToIntroduction (segue: UIStoryboardSegue) {
    }
    
    //set statusbar to white text
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
