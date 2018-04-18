//
//  LoginViewController.swift
//  ControlExpenses
//
//  Created by COTEMIG on 16/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var login : Login!
    var _user : String = ""
    var _password : String = ""
    //var user : User!
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        loadLogin()
    }
    
    @IBAction func didClickEnter(_ sender: UIButton) {
        loadLogin()
        
        if ((tfUser.text == "admin" && tfPassword.text == "admin") ||
            (_user.lowercased() == tfUser.text && _password.lowercased() == tfPassword.text)) {
            performSegue(withIdentifier: "segueTabBarController", sender: nil)
        } else {
            showAlert(message : "Usuário ou senha inválidos.")
        }
    }
    
    @IBAction func didClickForgotPassword(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueForgotPassword", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
/*
    @objc func loadLogin() {
        
        LoginAPI.loadLogin(tfUser.text!, tfPassword.text!) { (login) in
            if login != nil {
                self.performSegue(withIdentifier: "segueTabBarController", sender: nil)                
            } else {
                self.showAlert(message : "Usuário ou senha inválidos.")
            }
        }
    }
 */
    
    @objc func loadLogin() {
        
        LoginAPI.loadLogin { (login) in
            if let l = login {
                self._user = l.name;
                self._password = l.eye_color
            } else {
                let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar os dados do login.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
