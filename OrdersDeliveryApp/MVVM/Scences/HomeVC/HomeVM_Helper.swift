//
//  HomeVM_Struct.swift
//  OrdersDeliveryApp
//
//  Created by mostafa elsanadidy on 17.05.23.
//

import Foundation
import UIKit

struct OrdersBill{
    var date:String
    var totalprice:Double
    var deliveryStatus:DeliveryStatus
    var serialNum:String
}

enum DeliveryStatusEnum:String {
    case Delivered
    case Returned
    case Delivering
    case New
}

struct DeliveryStatus{
    var type_no:String
    var type_name:DeliveryStatusEnum{
        switch type_no{
        case "1":return .Delivered
        case "2":return .Delivering
        case "3":return .Returned
            default:return .New}
    }
    var type_Color:UIColor{
        switch type_no{
        case "1":return #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
        case "2":return #colorLiteral(red: 0, green: 0.3823715746, blue: 0.4604289532, alpha: 1)
        case "3":return #colorLiteral(red: 0.8725937009, green: 0.2503118515, blue: 0.05903184414, alpha: 1)
        default: return #colorLiteral(red: 0.1480861008, green: 0.8438410163, blue: 0.0612315163, alpha: 1)
         
        }
    }
    init(type_no:String) {
        self.type_no = type_no
    }
}
