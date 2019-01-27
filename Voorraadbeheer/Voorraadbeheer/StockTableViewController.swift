//
//  StockTableViewController.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 14/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit

class StockTableViewController: UITableViewController {
    
    //variables
    var product : [products] = []
    var loginuser : String?
    var filteredproducts = [products]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
        navigationItem.leftBarButtonItem = editButtonItem //add editbutton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Zoek producten"
        searchController.searchBar.setTextColor(color: .white) // doesn't work, make text in searchbar white
        searchController.searchBar.scopeButtonTitles = ["Alle", "Schaars", "Niet schaars"] //scopebuttontitles
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    func updateUI(with product: [products]) {
        DispatchQueue.main.async {
            self.product = product
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredproducts.count
        }
        return product.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductIdentifier", for: indexPath) as! StockTableViewCell
        let productje : products
        if isFiltering() {
            productje = filteredproducts[indexPath.row]
        } else {
            productje = product[indexPath.row]
        }
        cell.productNameLabel.text = productje.title
        cell.quantityLabel.text = productje.quantity
        cell.quantityTypeLabel.text = productje.quantity_type
        if Double(productje.quantity)! >= Double(productje.notification_quantity)! {
            cell.backgroundColor = UIColor.white
            cell.productNameLabel.textColor = UIColor.black
            cell.quantityLabel.textColor = UIColor.black
            cell.quantityTypeLabel.textColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor(red: 1, green: 0.549, blue: 0.549, alpha: 1.0) /* #ff8c8c */
            cell.productNameLabel.textColor = UIColor.white
            cell.quantityLabel.textColor = UIColor.white
            cell.quantityTypeLabel.textColor = UIColor.white
        }
        changeQuantity(id: productje.id, quantity: String(cell.stepperOutlet.value))
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let productje = product[indexPath.row]
        if editingStyle == .delete {
            deleteProduct(id: productje.id)
            product.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteProduct(id: productje.id)
    }
    
    
    // Functions for searchbar
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredproducts = product.filter({( product : products) -> Bool in
            let doesCategoryMatch = (scope == "Alle producten") || (product.scarce_product == scope)
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && product.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    //functions to delete or change a product
    func deleteProduct (id: Int) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/\(loginuser!)/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    
    func changeQuantity (id: Int, quantity: String) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/\(loginuser!)/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let postString = "quantity=\(quantity)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    
    // unwind to this page from addtostocktableviewcontroller
    @IBAction func unwindToStockTableView (segue: UIStoryboardSegue) {
        }

    
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        //show details of a product from the tableview
        if segue.identifier == "showDetails" {
            let AddToStockTableViewController = segue.destination as! AddToStockTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedproduct = product[indexPath.row]
            AddToStockTableViewController.alreadyfilledin = true
            AddToStockTableViewController.product = selectedproduct
            AddToStockTableViewController.loginuser = loginuser!

        }
        //add a product
        if segue.identifier == "addproduct" {
            let navController = segue.destination as! UINavigationController
            let AddToStockTableViewController = navController.topViewController as! AddToStockTableViewController
            AddToStockTableViewController.loginuser = loginuser!
        }
    }
}
// extension for searchbar
extension StockTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

}
public extension UISearchBar {
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}
// extension for scopebar
extension StockTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

