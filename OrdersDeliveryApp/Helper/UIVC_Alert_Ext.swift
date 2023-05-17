//
//  UIVC_Alert_Ext.swift
//  Zawidha
//
//  Created by Maher on 10/12/20.
//

import UIKit

extension UIViewController{
    
    func show_Popup (title : String = "" , body : String , okBtnTitle:String = "" , type : Alert_Type , status : Alert_Status , completionHandler : ((Bool)->())? = nil ) {
        let vc = AlertVC()
        if title.isEmpty == true{
            if status == .failure {
                vc.alert_Title = "Wrong!!"
                vc.emojiImageName = "grimacing"
                vc.okBtnTitle = okBtnTitle
                if okBtnTitle == ""{
                    vc.okBtnTitle = "Back"}
            } else {
                vc.alert_Title = "Success"
                vc.emojiImageName = "emoji-5"
                vc.okBtnTitle = okBtnTitle
                if okBtnTitle == ""{
                    vc.okBtnTitle = "Go"}
            }
        } else {
            if title == "no internet connection"{
                vc.alert_Title = "لا يوجد إتصال"
                vc.alert_Body = body
                vc.yesOptionalTypeBttnText = "إعادة المحاولة"
                vc.noOptionalTypeBttnText = "إلغاء"
                vc.emojiImageName = "suspicious"
            }
        }
        vc.alert_Body = body
        vc.alert_Type = type
        vc.alert_Status = status
        vc.completionHandler = completionHandler
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {[weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
}
