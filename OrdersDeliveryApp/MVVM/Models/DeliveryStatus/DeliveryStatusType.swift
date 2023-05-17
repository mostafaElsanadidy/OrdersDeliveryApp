//
//  DeliveryStatusType.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import SwiftyJSON

class DeliveryStatusType{

    var tYPNM : String!
    var tYPNO : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        tYPNM = json["TYP_NM"].stringValue
        tYPNO = json["TYP_NO"].stringValue
    }

}
