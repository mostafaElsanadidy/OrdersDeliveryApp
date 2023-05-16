//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class RootClass{

	var homeData : HomeData!
	var result : ResponseInfo!
    var loginData : LoginData!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let dataJson = json["Data"]
		if !dataJson.isEmpty{
            if !dataJson["DeliveryBills"].isEmpty{
                homeData = HomeData(fromJson: dataJson)
            }
            if !dataJson["DeliveryName"].isEmpty{
                loginData = LoginData(fromJson: dataJson)
            }
		}
		let resultJson = json["Result"]
		if !resultJson.isEmpty{
			result = ResponseInfo(fromJson: resultJson)
		}
	}

}
