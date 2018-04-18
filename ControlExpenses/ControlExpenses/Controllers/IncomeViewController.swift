//
//  IncomeViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 23/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    
    @IBOutlet weak var tfDescript: UITextField!
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var btDelete: UIButton!
    
    var income : Income?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if (income != nil)
        {
            tfDescript.text = income?.descript
            tfValue.text = Utils.shared.decimalToString(income!.value!)
            tfDate.text = Utils.shared.dateToString(income!.date!)
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
        
        if income == nil {
            income = Income(context: context)
        }
        
        if validaIncome() {
            income?.descript = tfDescript.text
            income?.value = NSDecimalNumber(string: tfValue.text!)
            income?.date = Utils.shared.stringToDate(tfDate.text!)
            
            let calendar = Calendar.current
            income?.month = Int16(calendar.component(.month, from: income!.date!))
            income?.year = Int16(calendar.component(.year, from: income!.date!))
            
            IncomeManager.shared.saveIncome(with: context)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didClickDelete(_ sender: UIButton) {
        
        deleteIncome()
    }
    
    @IBAction func didClickCancel(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func deleteIncome() {
        
        let title = "Atenção!"
        let message = "Deseja excluir a receita?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Não", style: .cancel)
        
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Sim", style: .default) { (action) in
            IncomeManager.shared.deleteIncome(self.income!, with: self.context)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validaIncome() -> Bool {
        
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
