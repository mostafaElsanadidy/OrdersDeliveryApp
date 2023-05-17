//
//  HomeVC.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 15.05.23.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var segmentView: UIViewX!
    @IBOutlet weak var moveView: UIViewX!
    @IBOutlet weak var firstSegmentLbl: UILabel!
    @IBOutlet weak var secondSegmentLbl: UILabel!
    @IBOutlet weak var firstDeliveryName: UILabel!
    @IBOutlet weak var secondDeliveryName: UILabel!
    @IBOutlet weak var OrdersTableView: UITableView!
    
    var homeViewModel : HomeList_VM?
    var coordinator : HomeCoordinator?
    
    func setupBinder(){
        homeViewModel?.OrdersBills.bind{
            [weak self] deliveryBills in
            guard let strongSelf = self else{return}
            DispatchQueue.main.async{
                strongSelf.OrdersTableView.reloadData()
                strongSelf.OrdersTableView.alpha = 1
            }
        }
        
            homeViewModel?.deliveryPerson.bind{
                [weak self] deliveryPerson in
                guard let strongSelf = self else{return}
                DispatchQueue.main.async{
                    strongSelf.firstDeliveryName.text = deliveryPerson?.name ?? ""
                    strongSelf.secondDeliveryName.text = ""
                }
            }
    }
    
    func initialState(viewModel:HomeList_VM) {
        self.homeViewModel = viewModel
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBinder()
   
        OrdersTableView.dataSource = self
        OrdersTableView.delegate = self
        OrdersTableView.register(UINib.init(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel?.viewWillAppear()
    }
    
    
    // MARK: - Switch Buttons
    @IBAction func switch_Buttons(_ sender: UIButton) {
        var current_Tag = homeViewModel?.selectedSegmentIndex
        if sender.tag != current_Tag {
            current_Tag = sender.tag
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.moveView.center.x = sender.center.x
                let _ = sender.tag == 0 ? self?.tag_0_Pressed() : self?.tag_1_Pressed()
                self?.homeViewModel?.selectedSegmentIndex = sender.tag
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Tag 0 Pressed
    private func tag_0_Pressed() {
        firstSegmentLbl.textColor = .white
        secondSegmentLbl.textColor = #colorLiteral(red: 0, green: 0.3823715746, blue: 0.4604289532, alpha: 1)
    }
    // MARK: - Tag 1 Pressed
    private func tag_1_Pressed() {
        firstSegmentLbl.textColor = #colorLiteral(red: 0, green: 0.3823715746, blue: 0.4604289532, alpha: 1)
        secondSegmentLbl.textColor = .white
    }
    
}
