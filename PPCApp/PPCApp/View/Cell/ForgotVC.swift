//
//  ForgotVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/31/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ForgotVC: BaseVC{
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
         title = LanguageManager.shared.localized(string: "forgotpass")
    }
    override func setupNavBar() {
        super.setupNavBar()
        addCompleteButton()
    }
    
    func addCompleteButton(){
        let completeButton = UIBarButtonItem(title: LanguageManager.shared.localized(string: "complete") , style: .done, target: self, action: #selector(handleCompleteForgot))
        completeButton.customTitle()
        completeButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = completeButton
    }

    func handleCompleteForgot(){
        if checkInputEmail(){
            if validateEmail(email: emailTextField.text!){
                MoreService.shared.forgotPassword(email: emailTextField.text!, completion: { (message) in
                    if message == 0{
                        
                    }else{
                        
                    }
                })
            }else{
                self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "incorrectEmail")!)
            }
            
        }else{
            self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "message_inputinfo")!)
        }

    }
    
    func validateEmail(email: String) ->Bool {
        let mobileFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileFormat)
        let mobileTestResult = mobileTest.evaluate(with: email)
        if mobileTestResult {
            return true
        }
        return false
    }
    
    func checkInputEmail()-> Bool{
        if (emailTextField.text?.isEmpty)!{
            return false
        }
        return true
    }
    func showAlertController(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
}
