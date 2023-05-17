


import Foundation 
import SwiftyJSON

class RootClass{

	var homeData : HomeData!
	var result : ResponseInfo!
    var loginData : LoginData!
    var billItemsData : BillItemsData!
    var deliveryStatusData : DeliveryStatusData!

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
            if dataJson["DeliveryName"].stringValue != ""{
                loginData = LoginData(fromJson: dataJson)
            }
            if !dataJson["DeliveryBillItems"].isEmpty{
                billItemsData = BillItemsData(fromJson: dataJson)
            }
            if !dataJson["DeliveryStatusTypes"].isEmpty{
                deliveryStatusData = DeliveryStatusData(fromJson: dataJson)
            }
            
		}
		let resultJson = json["Result"]
		if !resultJson.isEmpty{
			result = ResponseInfo(fromJson: resultJson)
		}
	}

}
