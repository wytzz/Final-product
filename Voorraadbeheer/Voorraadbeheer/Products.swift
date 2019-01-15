//
//  Products.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 14/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import Foundation

struct products : Codable {
    var id: Int
    var title : String
    var quantity: String
    var quantity_type : String
    var notification_quantity : String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        title = json["title"] as? String ?? ""
        quantity = json["quantity"] as? String ?? ""
        quantity_type = json["quantity_type"] as? String ?? ""
        notification_quantity = json["notifcation_quantity"] as? String ?? ""
        
    }
}


//static func loadSampleStock() -> [products] {
//    let product1 = products(title: "Pepersaus", quantity: 50, quantity_type: "liter", notification_quantity: 5)
//    let product2 = products(title: "Komkommer", quantity: 100, quantity_type: "stuks", notification_quantity: 10)
//    let product3 = products(title: "Tomaat", quantity: 30, quantity_type: "stuks", notification_quantity: 15)
//    let product4 = products(title: "Melk", quantity: 10, quantity_type: "liter", notification_quantity: 2)
//
//    return[product1, product2, product3, product4]
//}
