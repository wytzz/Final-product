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
        navigationItem.leftBarButtonItem = editButtonItem //add editbutton
        editButtonItem.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false //makes it possible to use the tableviewresults
        searchController.searchBar.placeholder = "Zoek producten" //placeholdertext of searchbar
        searchController.searchBar.tintColor = .white // scopetitles are white
        searchController.searchBar.scopeButtonTitles = ["Alle", "Schaars", "Niet schaars"] //scopebuttontitles
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        hideKeyboardWhenTappedAround()
    }
    
    //loads data from rester when view appears
    override func viewDidAppear(_ animated: Bool) {
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
    }
    
    //Changes values when view is dissapeared
    override func viewWillDisappear(_ animated: Bool) {
        valuestepperchangedQuantity()
    }
    
//    set statusbar to white text
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func updateUI(with product: [products]) {
        DispatchQueue.main.async {
            self.product = product
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() { //if fitered show filtered products
            return filteredproducts.count
        } // if not show all products
        return product.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductIdentifier", for: indexPath) as! StockTableViewCell
        let productje : products
        //set to all products or filtered products
        if isFiltering() {
            productje = filteredproducts[indexPath.row]
        } else {
            productje = product[indexPath.row]
        }
        //set values to labels
        cell.productNameLabel.text = productje.title
        cell.quantityLabel.text = productje.quantity
        cell.quantityTypeLabel.text = productje.quantity_type
        //if product quantity is less than notification make cell background red and text white
        if Double(productje.quantity)! > Double(productje.notification_quantity)! {
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
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let productje = product[indexPath.row]
        //if product is deleted in tableview
        if editingStyle == .delete {
            deleteProduct(id: productje.id)
            product.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //deletes product in rester
        deleteProduct(id: productje.id)
    }
    
    // if value is changed in stocktableview change it in rester
    func valuestepperchangedQuantity() {
        let totalSection = tableView.numberOfSections
        for section in 0..<totalSection {
            let totalRows = tableView.numberOfRows(inSection: section)
            for row in 0..<totalRows {
                var productje : products
                let indexPath = IndexPath(row: row, section: section)
                productje = product[indexPath.row]
                let cell = tableView.cellForRow(at: indexPath) as! StockTableViewCell
                changeQuantity(id: productje.id, quantity: cell.quantityLabel.text!, notificationQuantity: productje.notification_quantity)
                }
        }
        // make product empty so old data can't be seen
        product = []
        //load data again
        ProductController.shared.fetchProducts(user: loginuser!) { (product) in
            if let product = product {
                self.updateUI(with: product)
            }
        }
    }
    
    // Functions for searchbar
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Alle") {
        //valuestepperchangedQuantity()
        filteredproducts = product.filter({( product : products) -> Bool in
            let doesCategoryMatch = (scope == "Alle") || (product.scarce_product == scope)
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
    
    //functions to delete a product in rester
    func deleteProduct (id: Int) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/\(loginuser!)/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
    //change a product in rester
    func changeQuantity (id: Int, quantity: String, notificationQuantity: String) {
        let url = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/\(loginuser!)/\(id)")!
        var request = URLRequest(url: url)
        var scarceproduct : String
        //checks if product is scarce, adds string so scopebar can be made
        if Double(notificationQuantity)! >= Double(quantity)! {
            scarceproduct = "Schaars"
        } else {
            scarceproduct = "Niet schaars"
        }
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let postString = "quantity=\(quantity)&scarce_product=\(scarceproduct)"
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
            AddToStockTableViewController.product = selectedproduct
            AddToStockTableViewController.loginuser = loginuser!
            AddToStockTableViewController.isnewproduct = false

        }
        //segue to page for adding a product
        if segue.identifier == "addproduct" {
            let navController = segue.destination as! UINavigationController
            let AddToStockTableViewController = navController.topViewController as! AddToStockTableViewController
            AddToStockTableViewController.loginuser = loginuser!
            AddToStockTableViewController.isnewproduct = true
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


// extension for scopebar
extension StockTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

