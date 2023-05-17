//
//  MovieSearchCoordinator.swift
//  MoviesApp
//
//  Created by mostafa elsanadidy on 08.07.22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationPerformActionDelegate {
    func didPerformAction(with data:AnyObject)
}

class HomeCoordinator:Coordinator{
   
    weak var parentCoordinator : LoginCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var data:AnyObject?{
        didSet{
            start()
        }
    }
    
    init (navigationController: UINavigationController) {
    self.navigationController = navigationController
    }
    
    
    func start(){
        let vc = HomeVC()
        vc.coordinator = self
        let viewModel = HomeList_VM()
        viewModel.p_lang_no = "2"
        viewModel.deliveryPerson.value = (data as! DeliverPerson)
        vc.initialState(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
}
