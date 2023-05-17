//
//  DeliveryBill_Item.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import SwiftyJSON

class DeliveryBillItem{

    var bILLNO : String!
    var bILLSRL : String!
    var iTMUNT : String!
    var iCODE : String!
    var iNM : String!
    var iPRICE : String!
    var iPRICEVAT : String!
    var iQTY : String!
    var mOBILENO : String!
    var pSIZE : String!
    var vATAMT : String!
    var vATPRCNT : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bILLNO = json["BILL_NO"].stringValue
        bILLSRL = json["BILL_SRL"].stringValue
        iTMUNT = json["ITM_UNT"].stringValue
        iCODE = json["I_CODE"].stringValue
        iNM = json["I_NM"].stringValue
        iPRICE = json["I_PRICE"].stringValue
        iPRICEVAT = json["I_PRICE_VAT"].stringValue
        iQTY = json["I_QTY"].stringValue
        mOBILENO = json["MOBILE_NO"].stringValue
        pSIZE = json["P_SIZE"].stringValue
        vATAMT = json["VAT_AMT"].stringValue
        vATPRCNT = json["VAT_PRCNT"].stringValue
    }

}
