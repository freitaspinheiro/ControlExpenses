//
//  ExpenseManager.swift
//  ControlExpenses
//
//  Created by COTEMIG on 07/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import Foundation
import CoreData

class ExpenseManager {
    
    static let shared = ExpenseManager()
    var expenses : [Expense]!
    var month : Int16 = 0;
    var year :Int16 = 0;
    
    func loadExpenses(with context: NSManagedObjectContext) -> [Expense]? {

        let fetchRequest : NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "month = %ld AND year = %ld", month, year)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            try self.expenses = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return self.expenses
    }
    
    func saveExpense(with context: NSManagedObjectContext) {
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteExpense(_ expense: Expense, with context: NSManagedObjectContext) {
        
        context.delete(expense)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
