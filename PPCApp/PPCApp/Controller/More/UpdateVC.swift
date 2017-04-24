//
//  UpdateVC.swift
//  PPCApp
//
//  Created by NguoiNb on 4/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class UpdateVC: BaseVC {

    let delegate:SuccessLogin? = nil
    var userupdate:UserDefaults = UserDefaults()
    var userget:SigninModel = SigninModel()
    @IBOutlet weak var scroll: UIScrollView!
    @IBAction func Aavatarbtn(_ sender: Any) {
    }
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var fullnameImg: UIImageView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var phoneImg: UIImageView!
    @IBOutlet weak var addressImg: UIImageView!
    
    @IBOutlet weak var usertxt: UITextField!
    @IBOutlet weak var fullnametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var addresstxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Update"
        userImg.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        fullnameImg.image = UIImage.fontAwesomeIcon(name: .laptop, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        emailImg.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        phoneImg.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        addressImg.image = UIImage.fontAwesomeIcon(name: .map, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
        setupDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func setupDate(){
        if let user = userupdate.object(forKey: "user") {
            
            userget = SigninModel(dic: user as! Dictionary<String,Any>)
            avatarImg.loadImageurl(link: userget.avatar)
            usertxt.text = userget.username
            fullnametxt.text = userget.fullname
            emailtxt.text = userget.email
            phonetxt.text = userget.phone
            addresstxt.text = userget.address
            
        }
    }
    func completeupdate(){
        
    }
    func uploadSigup(link:String){
        let img = avatarImg.image
        let parameters = [
            "username":usertxt.text,
            "fullname":fullnametxt.text,
            "email":emailtxt.text,
            "phone":phonetxt.text,
            "address":a
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
                            Login = true
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
