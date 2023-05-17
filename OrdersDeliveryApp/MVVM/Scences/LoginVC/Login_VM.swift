//
//  Login_VM.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
final class Login_VM {
    
    
    var deliveryPerson :Observable<DeliverPerson?> = Observable(nil)
    var p_lang_no:String="",p_dlvry_no:String="",p_psswrd:String=""

    func checkUserAndLogin(userNum:String,password:String) {
        
        APIClient.checkDeliveryLogin(p_lang_no: "2", p_dlvry_no: userNum, p_psswrd: password){[weak self] (result) in
            guard let strongSelf = self else{return}

            switch result {
            case .failure(let error) :
                print(error.localizedDescription)
                
            case .success(let value) :
                guard let response = value else {
                    return }
                strongSelf.deliveryPerson.value = DeliverPerson(name: response.loginData?.deliveryName ?? "", userNum: userNum)
            }
        }
    }
    
}
