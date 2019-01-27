//
//  StockTableViewCell.swift
//  Voorraadbeheer
//
//  Created by Wytze Dijkstra on 16/01/2019.
//  Copyright © 2019 Wytze Dijkstra. All rights reserved.
//

import UIKit
protocol StockTableViewCellDegate {
    func changeQuantity(quantity: String)
}

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBAction func stepper(_ sender: UIStepper) {
        quantityLabel.text = String(Double(sender.value))
    }
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityTypeLabel: UILabel!
    
    var delegate : StockTableViewCellDegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        stepperOutlet.value = Double(quantityLabel.text!)!
    }

}
