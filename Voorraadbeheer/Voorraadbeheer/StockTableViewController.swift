//
//  StockTableViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 14/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit

class StockTableViewController: UITableViewController {

    var products : [products] = []

    override func viewDidAppear(_ animated: Bool) {
        ProductController.shared.fetchProducts() { (products) in
            if let products = products {
                self.updateUI(with: products)
            }
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func updateUI(with products: [products]) {
        DispatchQueue.main.async {
            self.products = products
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductIdentifier", for: indexPath) as! StockTableViewCell
        let productje = products[indexPath.row]
        cell.productNameLabel.text = productje.title
        cell.quantityLabel.text = productje.quantity
        cell.quantityTypeLabel.text = productje.quantity_type
        if Double(productje.quantity)! <= Double(productje.notification_quantity)! {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    func deleteProduct (id: Int) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/list")!
        var request = URLRequest(url: url)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        let delete = "/\(id)"
        request.httpBody = delete.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let productje = products[indexPath.row]
        if editingStyle == .delete {
            deleteProduct(id: productje.id)
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteProduct(id: productje.id)
    }
 

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
    
    @IBAction func unwindToStockTableView (segue: UIStoryboardSegue) {
            self.tableView.reloadData()
        
        }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "showDetails" {
            let AddToStockViewController = segue.destination as! AddToStockViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedproduct = products[indexPath.row]
            AddToStockViewController.product = selectedproduct
            
        }
        
    }
    

}
