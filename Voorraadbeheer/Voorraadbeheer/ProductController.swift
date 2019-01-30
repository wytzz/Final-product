//
//  ProductController.swift
//  
//
//  Created by Wytze Dijkstra on 15/01/2019.
//

import Foundation
import UIKit

class ProductController {
    
    static let shared = ProductController()
    //get products from rester database per user
    func fetchProducts(user: String, completion: @escaping ([products]?) -> Void) {
        let urlProducts = URL(string: "https://ide50-wytzz.legacy.cs50.io:8080/\(user)")!
        let task = URLSession.shared.dataTask(with: urlProducts) { (data, response, error) in
            do {
                if let data = data {
                    let producten = try JSONDecoder().decode([products].self, from: data)
                    completion(producten)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
