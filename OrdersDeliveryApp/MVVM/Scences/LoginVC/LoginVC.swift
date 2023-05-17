//
//  LoginVC.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import UIKit

class LoginVC: UIViewController {

    
    
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var userNumTextField: UITextFieldX!
    
    var coordinator : LoginCoordinator?
    var login_VM : Login_VM?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        setupBinder()
    }

    func setupBinder(){
        login_VM?.deliveryPerson.bind{
            [weak self] deliveryPerson in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                guard let deliveryPerson = deliveryPerson else{return}
                strongSelf.coordinator?.childShowOrders(with: deliveryPerson)
            }
        }
    }
    
    func initialState(viewModel:Login_VM) {
        self.login_VM = viewModel
    }
    

    @IBAction func loginUser(_ sender: UIButtonX) {
        let userNum = userNumTextField.text ?? ""
        let password = passwordTxtF.text ?? ""
        
        guard userNum == "1010" else{
            show_Popup(body: "User Number isn't valid", type: .single, status: .failure)
            return
        }
        guard password == "1" else{
            show_Popup(body: "maybe password isn't valid", type: .single, status: .failure)
            return}
        
        login_VM?.checkUserAndLogin(userNum: userNum, password: password)
    }
}
