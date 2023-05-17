//
//  HomeVC+Collection.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 15.05.23.
//

import Foundation
import UIKit

extension HomeVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel?.OrdersBills.value.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath)
        if let ordersCell = cell as? OrdersCell{
            let ordersBill = self.homeViewModel?.OrdersBills.value[indexPath.row]
            ordersCell.bill_dateLbl.text = ordersBill?.date
            ordersCell.serialNumLabel.text = "#"+(ordersBill?.serialNum ?? "")
            ordersCell.totalPriceLbl.text = "\(String(describing: Int(round(ordersBill?.totalprice ?? 0.0)))) LE"
            ordersCell.deliveryStatusLbl.text = ordersBill?.deliveryStatus.type_name.rawValue
            ordersCell.deliveryStatusLbl.textColor = ordersBill?.deliveryStatus.type_Color
            ordersCell.orderDetailsView.backgroundColor = ordersBill?.deliveryStatus.type_Color
        }
        return cell
    }
}
