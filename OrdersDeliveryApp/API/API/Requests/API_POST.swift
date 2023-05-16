//
//  API_POST.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient{
    // MARK: - Get Delivery Bills Items
    static func getDeliveryBillsItems(p_lang_no:String,p_dlvry_no:String,p_bill_srl:String,p_prcssd_flg:String, completionHandler : @escaping(Result<RootClass? , Result_Error>) -> Void) {
        ad.isLoading()
        performSwiftyRequest(route: .getDeliveryBillsItems(p_lang_no:p_lang_no,p_dlvry_no:p_dlvry_no,p_bill_srl:p_bill_srl,p_prcssd_flg:p_prcssd_flg)) { (jsonData) in
            let json = JSON(jsonData)
            guard let errNo = json["Result"]["ErrNo"].int,
            errNo != 0 else {
                DispatchQueue.main.async {
                    ad.killLoading()
                    let data = RootClass(fromJson: json)
                    completionHandler(.success(data))
                }
                return
            }
            ad.killLoading()
            let message = json["Result"]["ErrMsg"].string
            ad.CurrentRootVC()?.show_Popup(body: message ?? "", type: .single, status: .failure)
            completionHandler(.failure(.status_Failure))
            
        } _: { (error) in
            ad.killLoading()
            DispatchQueue.main.async {
                ad.CurrentRootVC()?.show_Popup(body: error.debugDescription, type: .single, status: .failure)
                completionHandler(.failure(.req_Failure))
            }
        }
    }
    
    static func checkDeliveryLogin(p_lang_no:String,p_dlvry_no:String,p_psswrd:String, completionHandler : @escaping(Result<RootClass? , Result_Error>) -> Void) {
        ad.isLoading()
        performSwiftyRequest(route: .checkDeliveryLogin(p_lang_no:p_lang_no,p_dlvry_no:p_dlvry_no,p_psswrd:p_psswrd)) { (jsonData) in
            let json = JSON(jsonData)
            guard let errNo = json["Result"]["ErrNo"].int,
            errNo != 0 else {
                DispatchQueue.main.async {
                    ad.killLoading()
                    let data = RootClass(fromJson: json)
                    completionHandler(.success(data))
                }
                return
            }
            ad.killLoading()
            let message = json["Result"]["ErrMsg"].string
            ad.CurrentRootVC()?.show_Popup(body: message ?? "", type: .single, status: .failure)
            completionHandler(.failure(.status_Failure))
            
        } _: { (error) in
            ad.killLoading()
            DispatchQueue.main.async {
                ad.CurrentRootVC()?.show_Popup(body: error.debugDescription, type: .single, status: .failure)
                completionHandler(.failure(.req_Failure))
            }
        }

    }

}
