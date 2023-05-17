//
//  HomeVC+Delegates.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 15.05.23.
//

import Foundation
import UIKit

extension HomeVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
