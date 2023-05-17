//
//  Home_VM.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation
import UIKit


final class HomeList_VM {
    
    var OrdersBills:Observable<[OrdersBill]> = Observable([])
    var p_lang_no = "", p_bill_srl = "", p_prcssd_flg = ""
    var deliveryBills : [DeliveryBill] = []
    var deliveryBillItems : [DeliveryBillItem] = []
    var managedObjectHandler:ManagedObjectHandler?
    var isWantToUpdate:Bool = false
    var deliveryStatusTypes:[DeliveryStatus] = []
    var selectedSegmentIndex:Int = 0{
        didSet{
            loadOrdersBills()
        }
    }
    var deliveryPerson:Observable<DeliverPerson?> = Observable(nil)
    
    init(){
        managedObjectHandler = ManagedObjectHandler()
    }
    
    func viewWillAppear() {
        
        let dispatchGroup = DispatchGroup()
        ad?.isLoading()
        
        dispatchGroup.enter()   // <<---
        APIClient.getDeliveryStatusTypes(p_lang_no: p_lang_no){[weak self] (result) in
            guard let strongSelf = self else{return}

            switch result {
            case .failure(let error) :
                print(error.localizedDescription)
                dispatchGroup.leave()
            case .success(let value) :
                guard let response = value else {
                    dispatchGroup.leave()
                    return }
                strongSelf.deliveryStatusTypes = response.deliveryStatusData.deliveryStatusTypes.map{.init(type_no: $0.tYPNO)}
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            ad?.killLoading()
            self.downloadDetails()
        }
    }
    
    
    func downloadDetails(){
        let dispatchGroup = DispatchGroup()
        ad?.isLoading()
        dispatchGroup.enter()   // <<---
        APIClient.getDeliveryBillsItems(p_lang_no: p_lang_no, p_dlvry_no: deliveryPerson.value?.userNum ?? "", p_bill_srl: p_bill_srl, p_prcssd_flg: p_prcssd_flg){[weak self] (result) in
            guard let strongSelf = self else{return}

            switch result {
            case .failure(let error) :
                print(error.localizedDescription)
                dispatchGroup.leave()
            case .success(let value) :
                guard let response = value else {
                    dispatchGroup.leave()
                    return }
                strongSelf.deliveryBills = response.homeData.deliveryBills
                
                    var counter = strongSelf.deliveryBills.count
                    if counter == 0 {
                        dispatchGroup.leave()
                    }
                
                else {
                    for (_, item) in strongSelf.deliveryBills.enumerated() {
                        dispatchGroup.enter()   // <<---
                        
                        APIClient.getDeliveryBillsItems(p_lang_no: strongSelf.p_lang_no, p_dlvry_no: strongSelf.deliveryPerson.value?.userNum ?? "", p_bill_srl: item.bILLSRL, p_prcssd_flg: strongSelf.p_prcssd_flg){[weak self] (result) in
                                           guard let strongSelf = self else{return}
                       
                                           switch result {
                                           case .failure(_) :
                                               dispatchGroup.leave()
                                           case .success(let value) :
                                               guard let response = value else {
                                                   dispatchGroup.leave()
                                                   return }

                                               let ordersBill = OrdersBill(date: item.bILLDATE, totalprice: response.billItemsData.deliveryBillItems.compactMap{Double($0.iPRICE)}.reduce(0.0,+), deliveryStatus: DeliveryStatus(type_no: item.dLVRYSTATUSFLG) , serialNum: item.bILLSRL)
                                               strongSelf.isWantToUpdate = true
                                               strongSelf.searchOrdersBills(with: [("serial_number", item.bILLSRL ?? "")],notFoundCompletion: {
                                                   strongSelf.saveOrdersBills(deliveryBill: ordersBill)
                                               },foundCompletion: {
                                                   strongSelf.updateOrdersBill(with: ordersBill)
                                               })
                                               dispatchGroup.leave()
                                           }
                            counter -= 1
                            if counter == 0 {
                                dispatchGroup.leave()
                            }
                                       }
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
            ad?.killLoading()
            self.loadOrdersBills()
        }
    }
    
    
}

