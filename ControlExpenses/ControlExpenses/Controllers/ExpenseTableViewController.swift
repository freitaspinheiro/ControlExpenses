//
//  ExpenseTableViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 07/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit
import CoreData

class ExpenseTableViewController: UITableViewController {
    
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        loadExpenses()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return self.expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let expense = self.expenses[indexPath.row]
        cell.lbDescript.text = expense.descript
        cell.lbValue.text = Utils.shared.formatMoney(expense.value!)
        cell.lbDate.text = Utils.shared.dateToString(expense.date!)
        
        if (expense.paid) {
            cell.lbPaid.text = "Quitada"
            cell.lbPaid.textColor = UIColor.blue
        } else {
            cell.lbPaid.text = "Pendente"
            cell.lbPaid.textColor = UIColor.red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source

            let title = "Atenção!"
            let message = "Deseja excluir a despesa?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Não", style: .cancel)
            
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "Sim", style: .default) { (action) in
                let expense = self.expenses[indexPath.row]
                ExpenseManager.shared.deleteExpense(expense, with: self.context)
                self.expenses.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueEditExpense" {
            if let _expenseViewControler = segue.destination as? ExpenseViewController {
                _expenseViewControler.expense = self.expenses[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    func loadExpenses() {
        
        if let expenses = ExpenseManager.shared.loadExpenses(with: context) {
            self.expenses = expenses
            self.tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar a lista de despesas.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
