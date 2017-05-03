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
import SwiftyJSON
class SignupVC: BaseVC,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var delegate:SuccessLogin?
    var sigup:SigninModel = SigninModel()
    let controller = UIImagePickerController()
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var avatabtn: UIButton!
    @IBOutlet weak var avataImg: UIImageView!
    @IBAction func Aavatabtn(_ sender: Any) {
        print("Click")
        
        //                let assets = PHAsset.fetchAssets(with: .image, options: nil)
        //                PHImageManager.default().requestImage(for: assets[0], targetSize: CGSize(width: 1000, height: 1000), contentMode: .default, options: nil, resultHandler: { (image, nil) in
        //                    //self.view.backgroundColor = UIColor.init(patternImage: image!)
        //                    self.avataImg.image = image
        //                })
        controller.delegate = self
        controller.sourceType = .photoLibrary
        //controller.allowsEditing = true
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var repassImage: UIImageView!
    @IBOutlet weak var fullnameImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var adressImage: UIImageView!
    
    @IBOutlet weak var usertxt: UITextField!
    @IBOutlet weak var passtxt: UITextField!
    @IBOutlet weak var repasstxt: UITextField!
    @IBOutlet weak var fullnametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phonetxt: UITextField!
    var phone:String{
        let phone = phonetxt.text
        return phone!
    }
    
    @IBOutlet weak var completebtn: UIButton!
    
    @IBAction func Acompletebtn(_ sender: Any) {
        uploadSigup(link: "http://api.perfectpropertyvn.com/vi/user/create")
        if sigup.message == 1{
            let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
            if emailTest.evaluate(with: emailtxt.text) == false {
                let alert = UIAlertController(title: "Thong Bao", message: "Email Khong Dung Vui Long Nhap Lai", preferredStyle: .alert)
                let act = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(act)
                present(alert, animated: true, completion: nil)
                
            }
            if phone.characters.count < 9 || phone.characters.count > 11{
                let alert1 = UIAlertController(title: "Thong Bao", message: "SDT Khong Dung Vui Long Nhap Lai", preferredStyle: .alert)
                let act1 = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert1.addAction(act1)
                present(alert1, animated: true, completion: nil)
                
            }
            else
            {
                uploadSigup(link: "http://api.perfectpropertyvn.com/vi/user/create")
            }
            
        }
    }
    var avataImage:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignUp"
        
        emailtxt.delegate = self
        address.delegate = self
        phonetxt.delegate = self
        fullnametxt.delegate = self
        avataImg.layer.cornerRadius = avataImg.frame.width / 2 - 10
        avataImg.clipsToBounds = true
        avataImg.image = UIImage.fontAwesomeIcon(name: .camera, textColor: .darkGray, size: CGSize(width: 120, height: 120))
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        passImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        //repassImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .addressCard, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: UIColor.darkGray, size: CGSize(width: 30, height: 30))
        adressImage.image = UIImage.fontAwesomeIcon(name: .map, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        completebtn.layer.cornerRadius = 3
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }
    func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selected = info[UIImagePickerControllerOriginalImage] as! UIImage
        avataImg.image = selected
        //avataImage = selected
        dismiss(animated: true, completion: nil)
    }
    func uploadSigup(link:String){
        let img = avataImg.image
        let parameters = [
            "username":usertxt.text,
            "password":passtxt.text,
            "fullname":fullnametxt.text,
            "email":emailtxt.text,
            "phone":phonetxt.text,
            "address":address.text
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let image = UIImageJPEGRepresentation(img!, 0.1){
                multipartFormData.append(image, withName: "avatar", fileName: "avata.jpeg", mimeType: "image/jpeg")
            }
            for (key,value) in parameters{
                multipartFormData.append((value?.data(using: .utf8))!, withName: key)
            }
        }, to: link) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    //print("ppppppppp\(response.result.value as Any)")
                    if let result = response.result.value as? Dictionary<String,Any>{
                        if result["message"] as! String == "1"{
                            
                            self.sigup = SigninModel(message: Int(result["message"] as! String)!, dic: result["data"] as! Dictionary<String, Any>)
                            let sigup = self.sigup.toDic(log: self.sigup)
                            UserDefaults.standard.set(sigup, forKey: "user")
                            self.delegate?.signUpSuccess(user: self.sigup)
                            self.dismiss(animated: true, completion: nil)
                            // print("iiiiiii\(self.sigup.avatar)")
                            
                        }
                        else{
                            let alert = UIAlertController(title: "Dang ky Khong Thanh Cong", message: result["note"] as? String, preferredStyle: UIAlertControllerStyle.alert)
                            let alertacation = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(alertacation)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    //sigup = SigninModel(message: (response.result.value?["message"])!, json: <#T##JSON#>)
                }
                break
                
            case .failure(let err):
                print("loiroi\(err)")
                break
            }
        }
    }
}

protocol Usersignup {
    func getusersignup(user:SigninModel)
}

