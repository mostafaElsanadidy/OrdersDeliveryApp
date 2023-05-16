//
//  HomeVC.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 15.05.23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var OrdersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segment.layer.cornerRadius = 30
//            segment.layer.borderWidth = 1
//            segment.layer.borderColor = UIColor.black.cgColor
//            segment.font(name: "TheSans-Plain", size: 14)
            segment.clipsToBounds = true
            segment.layer.masksToBounds = true
//        segment.color
        
        
            if #available(iOS 13.0, *) {
                segment.selectedSegmentTintColor = .red
            }
        
        OrdersTableView.dataSource = self
        OrdersTableView.delegate = self
        OrdersTableView.register(UINib.init(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
