//
//  ExpenseViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 07/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
    
    @IBOutlet weak var tfDescript: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var swDebtPaid: UISwitch!
    @IBOutlet weak var btDelete: UIButton!
    @IBOutlet weak var scCategories: UISegmentedControl!
    
    var expense : Expense?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if (expense != nil)
        {
            tfDescript.text = expense?.descript
            tfValue.text = Utils.shared.decimalToString(expense!.value!)
            tfDate.text = Utils.shared.dateToString(expense!.date!)
            scCategories.selectedSegmentIndex = Int(expense!.category)
            
            if let paid = expense?.paid {
                swDebtPaid.setOn(paid, animated: false)
            }
        } else {
            btDelete.isHidden = true
        }
        
        createDatePiker()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }    

    @IBAction func didClickSave(_ sender: UIButton) {
        
        if expense == nil {
            expense = Expense(context: context)
        }
        
        if validExpense() {
            expense?.descript = tfDescript.text
            expense?.value = NSDecimalNumber(string: tfValue.text!)
            expense?.paid = swDebtPaid.isOn
            expense?.date = Utils.shared.stringToDate(tfDate.text!)
            expense?.category = Int16(scCategories.selectedSegmentIndex)
            
            let calendar = Calendar.current
            expense?.month = Int16(calendar.component(.month, from: expense!.date!))
            expense?.year = Int16(calendar.component(.year, from: expense!.date!))
            
            ExpenseManager.shared.saveExpense(with: context)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didClickDelete(_ sender: UIButton) {
        
        deleteExpense()
    }
    
    @IBAction func didClickCancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func deleteExpense() {
        
        let title = "Atenção!"
        let message = "Deseja excluir a despesa?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Não", style: .cancel)
        
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Sim", style: .default) { (action) in
            ExpenseManager.shared.deleteExpense(self.expense!, with: self.context)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validExpense() -> Bool {
        
        if (tfDescript.text?.isEmpty)! {
            showAlert(message : "Descrição deve ser informada.")
            return false
        } else if (tfValue.text?.isEmpty)! {
            showAlert(message : "Valor deve ser informado.")
            return false
        } else if (NSDecimalNumber(string: tfValue.text!) == NSDecimalNumber(string: "0")) {
            showAlert(message : "Valor deve ser maior que zero.")
            return false
        }
        else if (tfDate.text?.isEmpty)! {
            showAlert(message : "Data deve ser informada.")
            return false
        }
        
        return true
    }
    
    /*********** Begin DatePicker ***********/
    
    let picker = UIDatePicker();
    
    func createDatePiker()
    {
        picker.locale = Locale.init(identifier: "pt-BR")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        tfDate.inputAccessoryView = toolbar;
        tfDate.inputView = picker
        picker.datePickerMode = .date
    }
    
    @objc func donePressed()
    {
        let dateFromString = Utils.shared.dateToString(picker.date)
        tfDate.text = "\(dateFromString)"
        self.view.endEditing(true)
    }
    
    /*********** End DatePicker ***********/
}
