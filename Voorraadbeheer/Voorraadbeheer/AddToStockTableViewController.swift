//
//  AddToStockTableViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 14/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit

class AddToStockTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var productNameTextfield: UITextField!
    @IBOutlet weak var quantityTypePickerView: UIPickerView!
    @IBOutlet weak var quantityTextfield: UITextField!
    @IBAction func quantityStepper(_ sender: UIStepper) {
        quantityTextfield.text = String(Int(sender.value))
    }
    @IBOutlet weak var notificationQuantityTextfield: UITextField!
    @IBAction func notificationQuantitystepper(_ sender: UIStepper) {
        notificationQuantityTextfield.text = String(Int(sender.value))
    }
    
    var product : products?
    
    private let dataSource = ["liters", "stuks", "gram", "kilogram", "flessen"]
    var selectedCategory : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityTypePickerView.dataSource = self
        quantityTypePickerView.delegate = self
        quantityTextfield.setBottomborder()
        notificationQuantityTextfield.setBottomborder()
        productNameTextfield.setBottomborder()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = dataSource[row]
    }




    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func putScoreInList (productname : String, selectedCategory : String, quantity: Int, notificationQuantity: Int) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "title=\(productname)&quantity_type=\(selectedCategory)&quantity=\(quantity)&notification_quantity=\(notificationQuantity))"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        putScoreInList(productname: productNameTextfield.text!, selectedCategory: selectedCategory, quantity: Int(quantityTextfield.text!)!, notificationQuantity: Int(notificationQuantityTextfield.text!)!)
    }

}
