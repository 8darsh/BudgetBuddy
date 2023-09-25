//
//  Balance+CoreDataProperties.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 25/09/23.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var currentBalance: String?
    @NSManaged public var income: String?
    @NSManaged public var expenseAmount: String?

}

extension Balance : Identifiable {

}
