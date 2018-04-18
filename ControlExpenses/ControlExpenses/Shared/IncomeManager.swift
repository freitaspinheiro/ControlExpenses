//
//  IncomeManager.swift
//  ControlExpenses
//
//  Created by COTEMIG on 23/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import Foundation
import CoreData

class IncomeManager {
    
    static let shared = IncomeManager()
    var incomes : [Income]!
    var month : Int16 = 0;
    var year : Int16 = 0;
    
    func loadIncomes(with context: NSManagedObjectContext) -> [Income]? {
        
        let fetchRequest : NSFetchRequest<Income> = Income.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "month = %ld AND year = %ld", month, year)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            try self.incomes = context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return self.incomes
    }
    
    func saveIncome(with context: NSManagedObjectContext) {
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteIncome(_ income: Income, with context: NSManagedObjectContext) {
        
        context.delete(income)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
