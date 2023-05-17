//
//  Bill_ItemsData.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import SwiftyJSON

class BillItemsData{

    var deliveryBillItems : [DeliveryBillItem]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        deliveryBillItems = [DeliveryBillItem]()
        let deliveryBillItemsArray = json["DeliveryBillItems"].arrayValue
        for deliveryBillItemsJson in deliveryBillItemsArray{
            let value = DeliveryBillItem(fromJson: deliveryBillItemsJson)
            deliveryBillItems.append(value)
        }
    }

}
