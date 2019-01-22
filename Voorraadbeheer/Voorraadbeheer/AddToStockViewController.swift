//
//  AddToStockViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 16/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit

class AddToStockViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var productNameTextfield: UITextField!
    @IBOutlet weak var quantityTypeTextfield: UITextField!
    @IBOutlet weak var quantityTextfield: UITextField!
    @IBAction func quantityStepper(_ sender: UIStepper) {
        quantityTextfield.text = String(Double(sender.value))
    }
    @IBOutlet weak var quantityStepperOutlet: UIStepper!
    @IBOutlet weak var notificationQuantityStepperOutlet: UIStepper!
    @IBOutlet weak var notificationQuantityTextfield: UITextField!
    @IBAction func notificationQuantityStepper(_ sender: UIStepper) {
        notificationQuantityTextfield.text = String(Double(sender.value))
    }
    @IBAction func quantityChanged(_ sender: UITextField) {
        quantityStepperOutlet.value = Double(quantityTextfield.text!)!
    }
    @IBAction func notificationQuantityChanged(_ sender: UITextField) {
        notificationQuantityStepperOutlet.value = Double(notificationQuantityTextfield.text!)!
    }
    @IBOutlet weak var notesTextfield: UITextField!
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if productNameTextfield.text?.isEmpty ?? true || quantityTextfield.text?.isEmpty ?? true || quantityTypeTextfield.text?.isEmpty ?? true || notificationQuantityTextfield.text?.isEmpty ?? true {
            let erroralert = UIAlertController(title: "There was a problem", message: "Alle velden behalve de notities moeten worden ingevuld!" , preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            erroralert.addAction(okButton)
            self.present(erroralert, animated: true, completion: nil)
        } else if Double(quantityTextfield.text!) == nil || Double(notificationQuantityTextfield.text!) == nil {
            let erroralert = UIAlertController(title: "There was a problem", message: "Vul alstublieft een getal in, inclusief decimalen!" , preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            erroralert.addAction(okButton)
            self.present(erroralert, animated: true, completion: nil)
        } else {
            let doublequantity = Double(quantityTextfield.text!)
            let doublenotificationquantity = Double(notificationQuantityTextfield.text!)
            putScoreInList(productname: productNameTextfield.text!, selectedCategory: quantityTypeTextfield.text!, quantity: doublequantity!, notificationQuantity: doublenotificationquantity!, notes: notesTextfield.text!)
            performSegue(withIdentifier: "saveUnwind", sender: self)
        }
        
    }
    
    let quantities = ["liters", "stuks", "gram", "kilogram", "flessen"]
    var selectedQuantity : String?
    var product : products?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createQuantityPicker()
        hideKeyboardWhenTappedAround()
        productNameTextfield.setBottomborder()
        quantityTypeTextfield.setBottomborder()
        quantityTextfield.setBottomborder()
        notificationQuantityTextfield.setBottomborder()
        notesTextfield.setBottomborder()
        if let product = product {
            productNameTextfield.text = product.title
            quantityTypeTextfield.text = product.quantity_type
            quantityTextfield.text = product.quantity
            notificationQuantityTextfield.text = product.notification_quantity
        }
    }

    func createQuantityPicker() {
        let quantityPicker = UIPickerView()
        quantityPicker.delegate = self
        quantityTypeTextfield.inputView = quantityPicker
        
    }
    func putScoreInList (productname : String, selectedCategory : String, quantity: Double, notificationQuantity: Double, notes: String) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "title=\(productname)&quantity_type=\(selectedCategory)&quantity=\(quantity)&notification_quantity=\(notificationQuantity)&notes=\(notes)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quantities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedQuantity = quantities[row]
        quantityTypeTextfield.text = selectedQuantity
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

