//
//  LoginData.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//


import Foundation
import SwiftyJSON

class LoginData{

    var deliveryName : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        deliveryName = json["DeliveryName"].stringValue
    }

}
