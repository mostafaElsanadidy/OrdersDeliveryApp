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
//    /movie?api_key=18f1dd9d9a6779af535c45513bd22779&query=The%20Avengers
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
//            el vend details fel post man get request w hena maktop .post ?
        case .getDeliveryBillsItems , .checkDeliveryLogin:
            return .post
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getDeliveryBillsItems: return "/OnyxDeliveryService/Service.svc/GetDeliveryBillsItems"
        case .checkDeliveryLogin: return "/OnyxDeliveryService/Service.svc/CheckDeliveryLogin"
        }
    }
    
    // MARK: - Parameters
//    why get api calls has no parameters and directly inserted within the url or if path == ta7t
    private var parameters: Parameters? {
        switch self {
            
        case.getDeliveryBillsItems(let p_lang_no,let p_dlvry_no,let p_bill_srl,let p_prcssd_flg):
            let parameters: [String:Any] = [
            "P_DLVRY_NO" : p_dlvry_no ,
            "P_LANG_NO" : p_lang_no ,
            "P_BILL_SRL" : p_bill_srl ,
            "P_PRCSSD_FLG" : p_prcssd_flg
            ]
            return parameters
            
        case.getDeliveryBillsItems(let p_lang_no,let p_dlvry_no,let p_psswrd):
            let parameters: [String:Any] = [
            "P_DLVRY_NO" : p_dlvry_no ,
            "P_LANG_NO" : p_lang_no ,
            "P_PSSWRD" : p_bill_srl
            ]
            return parameters
       
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var main_api_url = ""
        main_api_url = Constants.ProductionServer.baseURL + path
        let urlComponents = URLComponents(string: main_api_url)!
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
        print("URLS REQUEST :\(urlRequest)")
        
        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//        let credentialData = "ck_37baea2e07c8960059930bf348d286c7e48eb325:cs_0d74440eb12ac4726080563a4ceb0363ad5a0112".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//        let base64Credentials = credentialData.base64EncodedString()
//        let headers = "Basic \(base64Credentials)"
//
//        urlRequest.setValue(headers, forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print(parameters)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }


        }
        


//        if path == "login.php" || path == "edit_profile.php" || path == "edit_avatar.php" || path == "insertorder.php" || path == "add_customer_adrs.php" || path == "insert_order_cart.php"{
//            return try URLEncoding.default.encode(urlRequest, with: parameters)
//        }
        

        
        return urlRequest as URLRequest
        

    }
}
