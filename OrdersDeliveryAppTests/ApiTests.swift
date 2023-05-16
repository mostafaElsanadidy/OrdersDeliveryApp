//
//  ApiTests.swift
//  Recipes_APPTests
//
//  Created by mostafa elsanadidy on 17.11.22.
//

import Foundation
import XCTest

@testable import OrdersDeliveryApp

class ApiTests:XCTestCase{
    
    let timeOut : TimeInterval = 600
    var expectation : XCTestExpectation!
    
    var recipes : RootClass!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        expectation = XCTestExpectation.init(description: "Server Respond in time")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        recipes = nil
    }
    
    func testGetDeliveryBillsItems(){
        
//        {[weak self] (result) in
//            guard let strongSelf = self else{return}
//
//            switch result {
//            case .failure(let error) :
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
//            case .success(let value) :
//                guard let recipes_data = value else { return  }
//                strongSelf.presenter?.interactorDidFetchRecipes(with: .success(recipes_data))
//            }
//        }
        APIClient.getDeliveryBillsItems(p_lang_no: "2", p_dlvry_no: "1010", p_bill_srl: "", p_prcssd_flg:"" , completionHandler: {
            result in
            
            switch result{
                            case .failure(let error) :
//                                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
                                defer { self.expectation.fulfill() }
                print(error)
                                XCTAssertNil(error)
                            case .success(let value) :
//                                guard let recipes_data = value else { return  }
                defer { self.expectation.fulfill() }
                print(value!.homeData.deliveryBills!.map{$0.bILLAMT})
                XCTAssertNotEqual(value!.homeData.deliveryBills!.map{$0.bILLAMT}, nil)
//                XCTAssertNotEqual(value!.hits!.map{$0.recipe.label}, [])
                            }
        })
        wait(for: [expectation], timeout: timeOut)
    }
    
    
    func testCheckDeliveryLogin(){
        APIClient.checkDeliveryLogin(p_lang_no: "2", p_dlvry_no: "1010", p_psswrd: "1", completionHandler: {
            result in
            
            switch result{
                            case .failure(let error) :
//                                strongSelf.presenter?.interactorDidFetchRecipes(with: .failure(error))
                                defer { self.expectation.fulfill() }
                print(error)
                                XCTAssertNil(error)
                            case .success(let value) :
//                                guard let recipes_data = value else { return  }
                defer { self.expectation.fulfill() }
                print(value!.homeData.deliveryBills!.map{$0.bILLAMT})
                XCTAssertNotEqual(value!.loginData.deliveryName, nil)
//                XCTAssertNotEqual(value!.hits!.map{$0.recipe.label}, [])
                            }
        })
        wait(for: [expectation], timeout: timeOut)
    }
    
    
    func testPerformanceExample() throws {
           // This is an example of a performance test case.
           self.measure {
               // Put the code you want to measure the time of here.
           }
       }

}
