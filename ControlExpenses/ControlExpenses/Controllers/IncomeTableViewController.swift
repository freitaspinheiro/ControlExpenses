//
//  IncomeTableViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 23/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit
import CoreData

class IncomeTableViewController: UITableViewController {
    
    var incomes = [Income]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        loadIncomes()
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
        return self.incomes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IncomeTableViewCell
        let income = self.incomes[indexPath.row]
        cell.lbDescript.text = income.descript        
        cell.lbValue.text = Utils.shared.formatMoney(income.value!)
        cell.lbDate.text = Utils.shared.dateToString(income.date!)
        
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
            let message = "Deseja excluir a receita?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Não", style: .cancel)
            
            alert.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "Sim", style: .default) { (action) in
                let income = self.incomes[indexPath.row]
                IncomeManager.shared.deleteIncome(income, with: self.context)
                self.incomes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueEditIncome" {
            if let _incomeViewControler = segue.destination as? IncomeViewController {
                _incomeViewControler.income = self.incomes[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    func loadIncomes() {
        
        if let incomes = IncomeManager.shared.loadIncomes(with: context) {
            self.incomes = incomes
            self.tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar a lista de receitas.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
