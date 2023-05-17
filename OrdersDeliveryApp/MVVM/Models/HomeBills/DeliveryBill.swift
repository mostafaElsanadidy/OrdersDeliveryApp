//
//  DeliveryBill.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//


import Foundation 
import SwiftyJSON

class DeliveryBill{

	var bILLAMT : String!
	var bILLDATE : String!
	var bILLNO : String!
	var bILLSRL : String!
	var bILLTIME : String!
	var bILLTYPE : String!
	var cSTMRADDRSS : String!
	var cSTMRAPRTMNTNO : String!
	var cSTMRBUILDNO : String!
	var cSTMRFLOORNO : String!
	var cSTMRNM : String!
	var dLVRYAMT : String!
	var dLVRYSTATUSFLG : String!
	var lATITUDE : String!
	var lONGITUDE : String!
	var mOBILENO : String!
	var rGNNM : String!
	var tAXAMT : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		bILLAMT = json["BILL_AMT"].stringValue
		bILLDATE = json["BILL_DATE"].stringValue
		bILLNO = json["BILL_NO"].stringValue
		bILLSRL = json["BILL_SRL"].stringValue
		bILLTIME = json["BILL_TIME"].stringValue
		bILLTYPE = json["BILL_TYPE"].stringValue
		cSTMRADDRSS = json["CSTMR_ADDRSS"].stringValue
		cSTMRAPRTMNTNO = json["CSTMR_APRTMNT_NO"].stringValue
		cSTMRBUILDNO = json["CSTMR_BUILD_NO"].stringValue
		cSTMRFLOORNO = json["CSTMR_FLOOR_NO"].stringValue
		cSTMRNM = json["CSTMR_NM"].stringValue
		dLVRYAMT = json["DLVRY_AMT"].stringValue
		dLVRYSTATUSFLG = json["DLVRY_STATUS_FLG"].stringValue
		lATITUDE = json["LATITUDE"].stringValue
		lONGITUDE = json["LONGITUDE"].stringValue
		mOBILENO = json["MOBILE_NO"].stringValue
		rGNNM = json["RGN_NM"].stringValue
		tAXAMT = json["TAX_AMT"].stringValue
	}

}
