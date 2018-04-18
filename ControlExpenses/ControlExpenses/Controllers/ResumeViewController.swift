//
//  ResumeViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 15/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class ResumeViewController: UIViewController {
    
    @IBOutlet weak var lbSumExpense: UILabel!
    @IBOutlet weak var lbMonthYear: UILabel!
    @IBOutlet weak var lbSumIncome: UILabel!
    @IBOutlet weak var lbSumBalance: UILabel!
    
    var expenses = [Expense]()
    var incomes = [Income]()
    var year : Int16 = 0
    var month : Int16 = 0
    var expenseValue : Decimal = 0.0
    var incomeValue : Decimal = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let date = Date()
        let calendar = Calendar.current
        year = Int16(calendar.component(.year, from: date))
        month = Int16(calendar.component(.month, from: date))
        
        lbMonthYear.text = getMonthYear(month, year)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        loadValues()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    @IBAction func didClickNext(_ sender: UIButton) {
        
        month = month + 1;
        
        if (month == 13) {
            month = 1
            year = year + 1
        }
        
        loadValues()
        
        lbMonthYear.text = getMonthYear(month, year)
    }
    
    @IBAction func didClickPrior(_ sender: UIButton) {
        
        month = month - 1;
        
        if (month == 0) {
            month = 12
            year = year - 1
        }
        
        loadValues()
        
        lbMonthYear.text = getMonthYear(month, year)
    }

    func loadIncomes() {
        
        IncomeManager.shared.year = year
        IncomeManager.shared.month = month
        
        if let incomes = IncomeManager.shared.loadIncomes(with: context) {
            self.incomes = incomes
            
            var sumValue : Decimal = 0.0
            
            for income in incomes {
                sumValue += income.value! as Decimal
            }
            
            lbSumIncome.text = Utils.shared.formatMoney(sumValue as NSDecimalNumber)
            incomeValue = sumValue
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar a lista de despesas.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func loadExpenses() {
        
        ExpenseManager.shared.year = year
        ExpenseManager.shared.month = month
        
        if let expenses = ExpenseManager.shared.loadExpenses(with: context) {
            self.expenses = expenses
            
            var sumValue : Decimal = 0.0

            for expense in expenses {
                sumValue += expense.value! as Decimal
            }
            
            lbSumExpense.text = Utils.shared.formatMoney(sumValue as NSDecimalNumber)
            expenseValue = sumValue
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar a lista de despesas.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func loadBalance() {
        
        let balanceValue = incomeValue - expenseValue
        lbSumBalance.text = Utils.shared.formatMoney(balanceValue as NSDecimalNumber)
        
        if (balanceValue >= 0) {
            lbSumBalance.textColor = UIColor.green
        } else {
            lbSumBalance.textColor = UIColor.red
        }
    }
    
    func loadValues() {
        
        loadIncomes()
        loadExpenses()
        loadBalance()
    }
    
    func getMonthYear(_ month: Int16, _ year: Int16) -> String {
        
        var monthString = ""
        
        switch month {
            case 1:
                monthString = "Janeiro"
            case 2:
                monthString = "Fevereiro"
            case 3:
                monthString = "Março"
            case 4:
                monthString = "Abril"
            case 5:
                monthString = "Maio"
            case 6:
                monthString = "Junho"
            case 7:
                monthString = "Julho"
            case 8:
                monthString = "Agosto"
            case 9:
                monthString = "Setembro"
            case 10:
                monthString = "Outubro"
            case 11:
                monthString = "Novembro"
            case 12:
                monthString = "Dezembro"
            default:
                monthString = ""
        }
        
        return monthString + ", " + String(describing: year)
    }
}
