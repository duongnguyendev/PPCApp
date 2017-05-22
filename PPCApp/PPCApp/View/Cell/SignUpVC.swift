//
//  Signup.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Alamofire
class SignUpVC: BaseVC,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var avataImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var comfirmImage: UIImageView!
    @IBOutlet weak var fullnameImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var adressImage: UIImageView!
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var avatarData:Data?
    var delegate: MoreVCDelegate?
    var signup = SigninModel()
    let avartaController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignUp"
        avataImage.layer.cornerRadius = 60
        avataImage.clipsToBounds = true
        avataImage.image = UIImage.fontAwesomeIcon(name: .camera, textColor: .navigationBar(), size: CGSize(width: 120, height: 120))
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        passImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        comfirmImage.image = UIImage(named: "confirm_pass")
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .laptop,textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        adressImage.image = UIImage.fontAwesomeIcon(name: .mapMarker, textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .navigationBar(), size: CGSize(width: 30, height: 30))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBAction func handleCompleteButton(_ sender: Any) {
        if checkInputInfo(){
            if validateEmail(email: emailTextField.text!){
                MoreService.shared.postSignUp(signup: signup, avatar: avatarData) { (signin,errMess) in
                    if errMess == "0"{
                        self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "message_signup")!)
                    }else if errMess == "1"{
                        if self.delegate != nil{
                            self.delegate?.SuccessSignUp(signup: signin!)
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
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
    func showAlertController(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dimiss", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func checkInputInfo()-> Bool{
        if (userTextField.text?.isEmpty)! || (passTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (addressTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (fullnameTextField.text?.isEmpty)! || avatarData == nil{
            return false
        }
        signup.username = userTextField.text!
        signup.password = passTextField.text!
        signup.email = emailTextField.text!
        signup.address = addressTextField.text!
        signup.phone = phoneTextField.text!
        signup.fullname = fullnameTextField.text!
        return true
    }
    @IBAction func phoneTextField_textChange(_ sender: Any) {
        let lenght = phoneTextField.text?.characters.count
        let metin = phoneTextField.text
        if lenght! > 11{
            let index = metin?.index((metin?.startIndex)!, offsetBy: 11)
            phoneTextField.text = phoneTextField.text?.substring(to: index!)
        }
    }
    @IBAction func handleAvatarSignup(_ sender: UITapGestureRecognizer) {
        avartaController.delegate = self
        avartaController.sourceType = .photoLibrary
        present(avartaController, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avataImage.image = image
        self.dismiss(animated: true, completion: nil)
        
        self.avatarData = UIImageJPEGRepresentation(image, 0.1)
    }
    
}



