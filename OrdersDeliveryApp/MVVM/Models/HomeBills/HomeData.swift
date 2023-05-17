//
//  HomeData.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//


import Foundation 
import SwiftyJSON

class HomeData{

	var deliveryBills : [DeliveryBill]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		deliveryBills = [DeliveryBill]()
		let deliveryBillsArray = json["DeliveryBills"].arrayValue
		for deliveryBillsJson in deliveryBillsArray{
			let value = DeliveryBill(fromJson: deliveryBillsJson)
			deliveryBills.append(value)
		}
	}

}
