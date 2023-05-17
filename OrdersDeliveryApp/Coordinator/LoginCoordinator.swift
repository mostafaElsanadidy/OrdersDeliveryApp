//
//  MainCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 08.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

struct DeliverPerson {
    var name:String
    var userNum:String
}
class LoginCoordinator:NSObject,Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
    self.navigationController = navigationController
    }
    
    
    func start() {
        navigationController.delegate = self
        let vc = LoginVC()
        vc.coordinator = self
        let login_VM = Login_VM()
        login_VM.p_lang_no = "2"
        vc.initialState(viewModel: login_VM)
        
        navigationController.pushViewController(vc, animated: false)}
    
    func childShowOrders(with deliverPerson:DeliverPerson){
        let child = HomeCoordinator.init(navigationController: navigationController)
        child.data = deliverPerson as AnyObject
        child.parentCoordinator = self
        childCoordinators.append(child)
    }
    
    func childDidFinish( child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break}
            }
        }
    }


extension LoginCoordinator : UINavigationControllerDelegate {
    
    func navigationController (_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool){
        guard let fromViewController = navigationController.transitionCoordinator?.viewController( forKey:.from) else{return}
        if navigationController.viewControllers.contains(fromViewController)
            {return}
        if let homeVC = fromViewController as? HomeVC{
            childDidFinish(child: homeVC.coordinator)}
    }
    
    
    
}
