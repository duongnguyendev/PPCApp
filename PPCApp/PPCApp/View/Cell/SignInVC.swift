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
protocol MoreVCDelegate {
    func SuccessSignIn(signin: SigninModel)
    func SuccessSignUp(signup: SigninModel,avatar: Data)
}
class SignInVC: BaseVC{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var delegate: MoreVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        passImage.image = UIImage.fontAwesomeIcon(name: FontAwesome.lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.navigationBar().cgColor
        signupButton.layer.cornerRadius = 5
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func handleSigInButton(_ sender: Any) {
        let username = userTextField.text
        let password = passTextField.text
        MoreService.shared.getSignIn(username: username!, password: password!) { (signModel, errMess) in
            if errMess == 1{
                MoreService.shared.saveSignIn(signin: signModel!)
                if self.delegate != nil{
                    self.delegate?.SuccessSignIn(signin: signModel!)
                     self.goBack()
                }
            }else{
                
            }
        }
    }
    @IBAction func handleSignUpButton(_ sender: Any) {
        let signupVC = SignUpVC()
        signupVC.delegate = self.delegate
        push(viewController: signupVC)
    }
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }

}
