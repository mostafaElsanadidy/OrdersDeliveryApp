//
//  Result.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//


import Foundation 
import SwiftyJSON

class ResponseInfo{

	var errMsg : String!
	var errNo : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		errMsg = json["ErrMsg"].stringValue
		errNo = json["ErrNo"].intValue
	}

}
