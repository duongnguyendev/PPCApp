//
//  SignInVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
//let userLogin:UserDefaults = UserDefaults()
class SignInVC: BaseVC,UITextFieldDelegate{
    var delegate:SuccessLogin?
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var passimage: UIImageView!
    @IBOutlet weak var usertxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var signinbtn: UIButton!
    
    @IBAction func Asiginbtn(_ sender: Any) {
        let params:[String:String] = ["username":usertxt.text!,"password":passtxt.text!]
        SiginService.share.postSignin(parameters: params) { (sig) in
            self.signin = sig
            if self.signin.message == 1
            {
                print("Thanhcong")
                Login = true
                let login:Dictionary<String,Any> = self.signin.toDic(log: self.signin)
                UserDefaults.standard.set(login, forKey: "user")
                
                self.delegate?.getUser(user: self.signin)
//                let manhinh = MoreVC()
//                self.present(viewController: manhinh)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Thong Bao", message: "Ban Dang Nhap Sai Roi", preferredStyle: UIAlertControllerStyle.alert)
                let alertacation = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(alertacation)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBOutlet weak var signupbtn: UIButton!
    var signin:SigninModel = SigninModel()
    @IBAction func Asignupbtn(_ sender: Any) {
        let sigup = Signup()
       present(viewController: sigup)
        }
    @IBAction func forgotpassbtn(_ sender: Any) {
    }
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignIn"
       usertxt.delegate = self
        passtxt.delegate = self
        userimage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        passimage.image = UIImage.fontAwesomeIcon(name: FontAwesome.lock, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        signupbtn.layer.borderWidth = 3
        signupbtn.layer.borderColor = signinbtn.layer.backgroundColor
//        signinbtn.layer.cornerRadius = 5
        signupbtn.layer.cornerRadius = 5
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scroll.contentInset = contentInsets
            self.scroll.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
//            if (!CGRectContainsPoint(aRect, keyboardSize.frame.origin)) {
//                self.scroll.scrollRectToVisible(keyboardSize.frame, animated: true)
//            }
           
        }
    }
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scroll.contentInset = contentInsets
        self.scroll.scrollIndicatorInsets = contentInsets
    }
}


protocol SuccessLogin {
    func getUser(user:SigninModel)
}
