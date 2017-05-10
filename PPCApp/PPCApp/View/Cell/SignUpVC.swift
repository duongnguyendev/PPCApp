//
//  Signup.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Photos
import Alamofire
class SignUpVC: BaseVC,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet weak var mainScrollView: UIScrollView!
    let controller = UIImagePickerController()
    @IBOutlet weak var avatarButton: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignUp"
        avataImage.layer.cornerRadius = 60
        avataImage.clipsToBounds = true
        avataImage.image = UIImage.fontAwesomeIcon(name: .camera, textColor: .darkGray, size: CGSize(width: 120, height: 120))
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        passImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        comfirmImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .laptop,textColor: .darkGray, size: CGSize(width: 30, height: 30))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        adressImage.image = UIImage.fontAwesomeIcon(name: .mapMarker, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        
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
        let signup = SigninModel()
        signup.username = userTextField.text!
        signup.password = passTextField.text!
        signup.email = emailTextField.text!
        signup.address = addressTextField.text!
        signup.phone = phoneTextField.text!
        signup.fullname = fullnameTextField.text!
        
        MoreService.shared.postSignUp(signup: signup, avatar: avatarData) { (errMess) in
            if errMess == "0"{
                
            }else if errMess == "1"{
                MoreService.shared.saveSignIn(signin: signup)
                if self.delegate != nil{
                    self.delegate?.SuccessSignUp(signup: signup,avatar: self.avatarData!)
                    self.goBack()
                }

                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func handleAvatarButton(_ sender: Any) {
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
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



