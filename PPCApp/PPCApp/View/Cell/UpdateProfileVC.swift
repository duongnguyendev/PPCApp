//
//  UpdateProfileVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
protocol ProfileVCDelegate {
    func SuccessUpdateProfile(profile: SigninModel)
}
class UpdateProfileVC: BaseVC{
    @IBOutlet weak var avatarImageView: CustomImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var fullnameImage: UIImageView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addresImage: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    let avartaController = UIImagePickerController()
    var avatarData:Data?
    var profile = SigninModel()
    var delegate:ProfileVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.layer.cornerRadius = (avatarImageView.bounds.size.height / 2.0)
        avatarImageView.clipsToBounds = true
        
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .addressCard, textColor: .darkGray, size: CGSize(width: 30, height: 30))

        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        addresImage.image = UIImage.fontAwesomeIcon(name: .mapMarker, textColor: .darkGray, size: CGSize(width: 30, height: 30))
      
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        userTextField.text = profile.username
        fullnameTextField.text = profile.fullname
        emailTextField.text = profile.email
        phoneTextField.text = profile.phone
        addressTextField.text = profile.address
        avatarImageView.loadImageUsingUrlString(urlString: profile.avatar)
    }
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "updateprofile")
    }
    override func setupNavBar() {
        super.setupNavBar()
        self.addCompleteButton()
    }
    func addCompleteButton(){
        let completeButton = UIBarButtonItem(title: LanguageManager.shared.localized(string: "complete") , style: .done, target: self, action: #selector(handleCompleteProfile))
        completeButton.customTitle()
        completeButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = completeButton
    }
    func handleCompleteProfile(){
        if checkInputProfile(){
            if validateEmail(email: emailTextField.text!){
                MoreService.shared.updateProfile(profile: profile, avatar: avatarData, completion: { (mProfile, errMess) in
                    if errMess == 0{
                        self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "message_signup")!)
                    }else if errMess == 1{
                         MoreService.shared.saveSignIn(signin: mProfile!)
                        if self.delegate != nil{
                            self.delegate?.SuccessUpdateProfile(profile: mProfile!)
                        }
                        self.goBack()
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

    func checkInputProfile()-> Bool{
        if (emailTextField.text?.isEmpty)! || (addressTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (fullnameTextField.text?.isEmpty)!{
            return false
        }
        profile.username = userTextField.text!
        profile.email = emailTextField.text!
        profile.address = addressTextField.text!
        profile.phone = phoneTextField.text!
        profile.fullname = fullnameTextField.text!
        return true
    }
    func showAlertController(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func phoneTextField_textChange(_ sender: Any) {
        let lenght = phoneTextField.text?.characters.count
        let metin = phoneTextField.text
        if lenght! > 11{
            let index = metin?.index((metin?.startIndex)!, offsetBy: 11)
            phoneTextField.text = phoneTextField.text?.substring(to: index!)
        }
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
    @IBAction func handleAvatarProfile(_ sender: UITapGestureRecognizer) {
        avartaController.delegate = self
        avartaController.sourceType = .photoLibrary
        present(avartaController, animated: true, completion: nil)
    }
}
extension UpdateProfileVC: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.avatarImageView.image = image
        self.dismiss(animated: true, completion: nil)
        self.avatarData = UIImageJPEGRepresentation(image, 0.1)
    }

}
