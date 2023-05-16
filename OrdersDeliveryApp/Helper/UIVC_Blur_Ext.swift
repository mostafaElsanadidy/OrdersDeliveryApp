//
//  UIVC_Blur_Ext.swift
//  Zawidha
//
//  Created by Maher on 10/6/20.
//

import UIKit

extension UIViewController {
    func set_Blur(containerView : UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.frame = containerView.frame
        containerView.insertSubview(blurEffectView, at: 0)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
