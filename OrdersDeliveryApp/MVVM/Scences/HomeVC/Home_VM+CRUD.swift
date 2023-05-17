//
//  Home_VM+CRUD.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 16.05.23.
//

import Foundation

enum coreDataStatus{
    case create
    case read
    case update
    case delete
    case search
}

extension HomeList_VM {
    
    typealias ManagedObjectHandler = CoreDataHandler<Managed_Bill>
    
    func saveOrdersBills(deliveryBill:OrdersBill) {

        guard let viewContext = viewContext else { return }
                let selectedBill = Managed_Bill.init(context: viewContext)
                    selectedBill.bill_date = deliveryBill.date
                    selectedBill.serial_number = deliveryBill.serialNum
                    selectedBill.total_price = deliveryBill.totalprice
                    selectedBill.deliveryStatus = deliveryBill.deliveryStatus.type_no
        managedObjectHandler?.saveItems(afterSaving: {
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.interactorDidAccessCoreData(with: .failure(error),state: .create)
            case .success(let value) :
                guard let orders_data = value else { return  }
                self.interactorDidAccessCoreData(with: .success(orders_data), state: .create)
            }
            
        })
    }

    func deleteOrdersBills(where serialNum: String) {
        let index = managedObjectHandler?.items.firstIndex(where: {
            ($0.serial_number == serialNum)
            })
          managedObjectHandler?.deleteItems(at:
                                                index ?? 0
                                                , afterDelete: {
              [unowned self]
              result in
              switch result {
              case .failure(let error) :
                  self.interactorDidAccessCoreData(with: .failure(error),state: .delete)
              case .success(let value) :
                  guard let bills_data = value else { return  }
                  self.interactorDidAccessCoreData(with: .success(bills_data), state: .delete)

              }
          })
      }

    func searchOrdersBills(with searchTuple: [(key: String, text: Any)], notFoundCompletion:@escaping ()->(), foundCompletion:@escaping ()->()) {
        managedObjectHandler?.searchForItem(with: searchTuple, initialRequest: Managed_Bill.fetchRequest(), didEndSearching: {
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.interactorDidAccessCoreData(with: .failure(error),state: .search,notFoundCompletion:notFoundCompletion, foundCompletion: foundCompletion)
            case .success(let value) :
                guard let bills_data = value else { return  }
                self.interactorDidAccessCoreData(with: .success(bills_data), state: .search,notFoundCompletion:notFoundCompletion, foundCompletion: foundCompletion)

            }
        })
    }

    func loadOrdersBills() {

        let searchValue = "1"
        if self.selectedSegmentIndex == 0 {
            // value for first index selected here
            self.searchOrdersBills(with: [("deliveryStatus",searchValue)], notFoundCompletion: {}, foundCompletion: {})
        }else{
            
            self.searchOrdersBills(with: self.deliveryStatusTypes.filter{$0.type_no != searchValue}.map{("deliveryStatus",$0.type_no)}, notFoundCompletion: {}, foundCompletion: {})
        }
    }

    func updateOrdersBill(with deliveryBill:OrdersBill) {
        managedObjectHandler?.updateItem(didBeginUpdating: {
            bills in
            bills[0].bill_date = deliveryBill.date
            bills[0].serial_number = deliveryBill.serialNum
            bills[0].total_price = deliveryBill.totalprice
            bills[0].deliveryStatus = deliveryBill.deliveryStatus.type_no
        }, didEndUpdating: {
            [unowned self]
            result in
            switch result {
            case .failure(let error) :
                self.interactorDidAccessCoreData(with: .failure(error),state: .update)
            case .success(let value) :
                guard let bills_data = value else { return  }
                self.interactorDidAccessCoreData(with: .success(bills_data), state: .update)

            }
        })
    }
    
    
    func interactorDidFetchMedicines(with result: Result<[Managed_Bill], Result_Error>) {
        switch result {
        case .failure(let error):
            self.update(with: error)
        case .success(let orders_data):
            self.OrdersBills.value = orders_data.map{.init(date: $0.bill_date ?? "", totalprice: $0.total_price, deliveryStatus: DeliveryStatus(type_no: $0.deliveryStatus ?? ""), serialNum: $0.serial_number ?? "")}
        }
    }
    
    func interactorDidAccessCoreData(with result: Result<[Managed_Bill], Result_Error>, state: coreDataStatus, notFoundCompletion:()->() = {}, foundCompletion:()->() = {}) {
        switch result {
        case .failure(let error):
            self.update(with: error)
        case .success(let orders_data):
        let orders = orders_data
        switch state {
        case .search:
            if isWantToUpdate{
                let count = orders.count
                if count == 0{
                    notFoundCompletion()
                }else{
                    foundCompletion()
                }
            }
        default:
            break
//            let _ = orders.map{print($0.serial_number ?? "")}
        }
        
            self.interactorDidFetchMedicines(with: result)
    }
    }

    func update(with error: Result_Error) {
        print(error.error_Desc)
    }
}
