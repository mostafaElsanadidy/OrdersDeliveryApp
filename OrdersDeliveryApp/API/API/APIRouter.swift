//
//  APIRouter.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getDeliveryBillsItems(p_lang_no:String,p_dlvry_no:String,p_bill_srl:String,p_prcssd_flg:String)
    case checkDeliveryLogin(p_lang_no:String,p_dlvry_no:String,p_psswrd:String)
    case getDeliveryStatusTypes(p_lang_no:String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getDeliveryBillsItems , .checkDeliveryLogin, .getDeliveryStatusTypes:
            return .post
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getDeliveryBillsItems: return "/OnyxDeliveryService/Service.svc/GetDeliveryBillsItems"
        case .checkDeliveryLogin: return "/OnyxDeliveryService/Service.svc/CheckDeliveryLogin"
        case .getDeliveryStatusTypes: return
            "/OnyxDeliveryService/Service.svc/GetDeliveryStatusTypes"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
            
        case.getDeliveryBillsItems(let p_lang_no,let p_dlvry_no,let p_bill_srl,let p_prcssd_flg):
            let parameters: [String:String] = [
            "P_DLVRY_NO" : p_dlvry_no ,
            "P_LANG_NO" : p_lang_no ,
            "P_BILL_SRL" : p_bill_srl ,
            "P_PRCSSD_FLG" : p_prcssd_flg
            ]
            return ["Value":parameters]
            
        case.checkDeliveryLogin(let p_lang_no,let p_dlvry_no,let p_psswrd):
            let parameters: [String:Any] = [
            "P_DLVRY_NO" : p_dlvry_no ,
            "P_LANG_NO" : p_lang_no ,
            "P_PSSWRD" : p_psswrd
            ]
            return ["Value":parameters]
       
        case .getDeliveryStatusTypes(let p_lang_no):
            let parameters: [String:Any] = [
            "P_LANG_NO" : p_lang_no 
            ]
            return ["Value":parameters]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var main_api_url = ""
        main_api_url = Constants.ProductionServer.baseURL + path
        let urlComponents = URLComponents(string: main_api_url)!
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
//        print("URLS REQUEST :\(urlRequest)")
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
        
            // Parameters
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        
        return urlRequest as URLRequest
    }
}
