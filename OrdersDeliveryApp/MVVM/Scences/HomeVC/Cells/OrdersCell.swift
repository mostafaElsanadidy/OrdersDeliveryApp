//
//  Orders_Cell.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import UIKit

class OrdersCell: UITableViewCell {

    @IBOutlet weak var serialNumLabel: UILabel!
    @IBOutlet weak var deliveryStatusLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var orderDetailsView: UIViewX!
    @IBOutlet weak var bill_dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
