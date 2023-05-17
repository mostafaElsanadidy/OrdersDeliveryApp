//
//  DelivertStatusData.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import SwiftyJSON

class DeliveryStatusData{
var deliveryStatusTypes : [DeliveryStatusType]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        deliveryStatusTypes = [DeliveryStatusType]()
        let deliveryStatusTypesArray = json["DeliveryStatusTypes"].arrayValue
        for deliveryStatusTypesJson in deliveryStatusTypesArray{
            let value = DeliveryStatusType(fromJson: deliveryStatusTypesJson)
            deliveryStatusTypes.append(value)
        }
    }
}

