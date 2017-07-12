//
//  ChangePassVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/9/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ChangePassVC: BaseVC{
    
    @IBOutlet weak var oldImage: UIImageView!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var confirmImage: UIImageView!
    
    @IBOutlet weak var oldTextField: UITextField!
    @IBOutlet weak var newTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    var profile = SigninModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        newImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        confirmImage.image = UIImage(named: "confirm_pass")
    }
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "changepass")
    }
    override func setupNavBar() {
        super.setupNavBar()
        self.addChangeButton()
        
    }
    func addChangeButton(){
        let changeButton = UIBarButtonItem(title: LanguageManager.shared.localized(string: "change"), style: .done, target: self, action: #selector(handleChangeButton))
        changeButton.customTitle()
        changeButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = changeButton
    }
    
    func handleChangeButton(){
        let oldpass = oldTextField.text!
        let newpass = newTextField.text!
        let confirmpass = confirmTextField.text!
        if checkInputChangePass(){
            if newpass == confirmpass{
                MoreService.shared.updatePassword(id: profile.id, oldpass: oldpass, newpass: newpass, completion: { (errMess) in
                    if errMess == 1{
                        self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "success_changepass")!)
                    }else if errMess == 0{
                          self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "incorrect_changepass")!)
                    }
                })
            }else{
                self.showAlertController(title: "OK", message: LanguageManager.shared.localized(string: "changepass")!)

            }
        }else{
            self.showAlertController(title: "OK", message: LanguageManager.shared.localized(string: "message_inputinfo")!)
        }
    }
    
    func checkInputChangePass()-> Bool{
        if (oldTextField.text?.isEmpty)! || (newTextField.text?.isEmpty)! || (confirmTextField.text?.isEmpty)!{
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
