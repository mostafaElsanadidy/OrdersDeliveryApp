//
//  Reload.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import UIKit
//import SideMenuController

protocol ReloadDelegate {
    func goToHomeVC(window:UIWindow)
}

extension ReloadDelegate {
    
    func goToHomeVC(window:UIWindow) {
        
        let navController = UINavigationController()
//        navController.isNavigationBarHidden = true
        let coordinator = LoginCoordinator.init(navigationController: navController)
        coordinator.start()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    
    }
}
