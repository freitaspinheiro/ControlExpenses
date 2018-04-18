//
//  Utils.swift
//  ControlExpenses
//
//  Created by COTEMIG on 28/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Utils: UIViewController {

    static let shared = Utils()
    
    func dateToString(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(_ date: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.date(from: date)!
    }

    func formatMoney(_ value: NSDecimalNumber) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.init(identifier: "pt-BR")
        currencyFormatter.currencySymbol = "R$ "
        
        return currencyFormatter.string(from: value)!
    }
    
    func decimalToString(_ value: NSDecimalNumber) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.minimumFractionDigits = 2
        
        return currencyFormatter.string(from: value)!
    }
}

extension UIViewController {
    
    var context : NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func showAlert(message : String) {
        
        let title = "Atenção"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
