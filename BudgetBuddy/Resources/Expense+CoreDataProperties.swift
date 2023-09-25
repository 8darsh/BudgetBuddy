//
//  Expense+CoreDataProperties.swift
//  BudgetBuddy
//
//  Created by Adarsh Singh on 25/09/23.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: String?
    @NSManaged public var date: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var type: Bool

}

extension Expense : Identifiable {

}
