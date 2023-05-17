////
////  SearchVC+CoreDataProcesses(CRUD).swift
////  RecipesApp
////
////  Created by mostafa elsanadidy on 25.06.22.
////
//
import Foundation
import CoreData
import UIKit
//
protocol AnyCoreDataHandler {
  //  var defaultHandler:()->(){get set}
   // var items:[T]{get set}
    associatedtype U
    associatedtype T
    func saveItems(afterSaving executionHandler:(Result<[T]? , Result_Error>) -> Void)
    func searchForItem(with searchTuple:[(key:String,text:Any)], parent parentItem:(key:String,name:String)?, initialRequest: U,didEndSearching handler:@escaping (Result<[T]? , Result_Error>) -> Void)
    func loadItems(with request: U, parent parentItem:(key:String,name:String)?, didEndLoading handler:(Result<[T]? , Result_Error>) -> Void)
    func updateItem(didBeginUpdating updateHandler:([T])->(), didEndUpdating afterUpdateHandler: (Result<[T]? , Result_Error>) -> Void)
    func deleteItems(at index:Int,afterDelete executionHandler: (Result<[T]? , Result_Error>) -> Void)
}
//
class CoreDataHandler<T:NSManagedObject>:AnyCoreDataHandler {
    
    var defaultHandler: () -> () = {}
    
    var items: [T] = []
    
    typealias U = NSFetchRequest<T>
   
    //MARK: - DEFAULT HANDLER
//    var defaultHandler: ()->() {
//        get {
//            return self.defaultHandler
//        }
//        set {
//            self.defaultHandler = newValue
//        }
//    }
    
   
    //MARK: - the D in the word CRUD
    func deleteItems(at index:Int,afterDelete executionHandler:(Result<[T]? , Result_Error>) -> Void) {
        viewContext?.delete(items[index])
        items.remove(at: index)
        saveItems(afterSaving: executionHandler)
    }
    
    //MARK: - the C in the word CRUD
    func saveItems(afterSaving executionHandler:(Result<[T]? , Result_Error>) -> Void){
        do {
            try viewContext?.save()
            executionHandler(.success(items))
        } catch {
            executionHandler(.failure(.status_Failure))
        }
    }
    
    //MARK: - the R in the word CRUD
    func searchForItem(with searchTuple:[(key:String,text:Any)], parent parentItem:(key:String,name:String)?=nil, initialRequest:NSFetchRequest<T>, didEndSearching handler: @escaping (Result<[T]? , Result_Error>) -> Void){
        
         let request:NSFetchRequest<T> = initialRequest
        var predicates:[NSPredicate] = []
        
        
        let dict = searchTuple.reduce([String:[Any]]()) { (result, item) -> [String:[Any]] in
            var result = result
            if result[item.key] == nil{
                result[item.key] = []
            }
            result[item.key]?.append(item.text)
            return result
        }
        
        for (key,searchTuple) in dict {
            var format:String = ""
            for (index,search_Tuple) in searchTuple.enumerated(){
                format += ("\(key) CONTAINS[cd] \(search_Tuple)")
            if index != searchTuple.count-1{
                format += (" OR ")
              }
            }
            
            predicates.append(NSPredicate(format: format))
        }
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        if parentItem == nil{
            request.predicate = predicate
        }else{
            let parentRestaurantPredicate = NSPredicate(format: "\(parentItem?.key ?? "") MATCHES %@",parentItem?.name ?? "")
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate,parentRestaurantPredicate])
        }
        request.sortDescriptors = [NSSortDescriptor(key: "\(searchTuple[0].key)", ascending: true)]
        loadItems(with: request, parent: nil, didEndLoading: handler)
    }
    
    func loadItems(with request: NSFetchRequest<T>, parent parentItem:(key:String,name:String)?=nil, didEndLoading handler: (Result<[T]? , Result_Error>) -> Void ) {
        do {
        
            if parentItem == nil{
              
            }else{
                let parentRestaurantPredicate = NSPredicate(format: "\(parentItem?.key ?? "") MATCHES %@",parentItem?.name ?? "")
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [parentRestaurantPredicate])
            }
            guard let viewContext = viewContext else { return }
            items = try viewContext.fetch(request)
            handler(.success(items))
        }
        catch {
            handler(.failure(.status_Failure))
        }
    }
    
    //MARK: - the U in the word CRUD
    func updateItem(didBeginUpdating updateHandler:([T])->(), didEndUpdating afterUpdateHandler:(Result<[T]? , Result_Error>) -> Void) {
       
        updateHandler(items)
       
        saveItems(afterSaving: afterUpdateHandler)
    }
}
