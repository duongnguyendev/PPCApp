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
        title = "ChangePass"
        oldImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        newImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        confirmImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 30, height: 30))
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        self.addChangeButton()
        
    }
    func addChangeButton(){
        let changeButton = UIBarButtonItem(title: "Change", style: .done, target: self, action: #selector(handleChangeButton))
        changeButton.customTitle()
        changeButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = changeButton
    }
    
    func handleChangeButton(){
        let oldpass = oldTextField.text!
        let newpass = newTextField.text!
        //let confirmpass = confirmTextField.text!
        
        MoreService.shared.updatePassword(id: profile.id, oldpass: oldpass, newpass: newpass)
        
    }
}
