//
//  DatabaseHelper.swift
//  BudgetBud
//
//  Created by Adarsh Singh on 23/09/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    init(){}
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object:[String:Any]){
        
        let expense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: context!) as! Expense
        

        expense.title = object["title"] as? String
        
        expense.amount = object["amount"] as? String
        expense.date = object["date"] as? String
        expense.image = object["image"] as? String
        expense.type = object["type"] as? Bool ?? true
        
        do{
            try context?.save()
        }catch{
            print("Not Saved")
        }
        
    }
    
    func getData()->[Expense]{
        var expenses = [Expense]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Expense")
        
        do{
            expenses = try context?.fetch(fetchRequest) as! [Expense]
        }catch{
            print("Can't get data")
        }
        
        return expenses
        
    }
    
    func deletData(index: Int) -> [Expense]{
        var expense = getData()
        context?.delete(expense[index])
        expense.remove(at: index)
        do{
            try context?.save()
        }catch{
            print("Not Saved")
        }
        
        return expense
        
    }
    
    func editData<T>(object:[String:T], i: Int){
        let expense = getData()
        expense[i].title = object["title"] as? String
        expense[i].amount = object["amount"] as? String
        expense[i].image = object["image"] as? String
        expense[i].date = object["date"] as? String
        
        do{
            try context?.save()
        }catch{
            print("Not edited")
        }
    }
    
}
