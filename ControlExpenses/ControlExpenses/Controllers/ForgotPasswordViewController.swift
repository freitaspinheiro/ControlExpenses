//
//  ForgotPasswordViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 16/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    @IBAction func didClickSendPassword(_ sender: UIButton) {
        
        if validEmail() {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didClickClose(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func validEmail() -> Bool {
        
        if (tfEmail.text?.isEmpty)! {
            showAlert(message : "E-mail deve ser informado.")
            return false
        }
        
        return true
    }
}
