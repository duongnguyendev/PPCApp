//
//  UpdateVC.swift
//  PPCApp
//
//  Created by NguoiNb on 4/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Alamofire
class UpdateVC: BaseVC,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var delegate:SuccessLogin?
    var userupdate:UserDefaults = UserDefaults()
    var userget:SigninModel = SigninModel()
    @IBOutlet weak var scroll: UIScrollView!
    @IBAction func Aavatarbtn(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
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
        avatarImg.layer.cornerRadius = avatarImg.bounds.size.height / 2.0 - 10
        avatarImg.clipsToBounds = true
        userImg.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        fullnameImg.image = UIImage.fontAwesomeIcon(name: .addressCard, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        emailImg.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        phoneImg.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        addressImg.image = UIImage.fontAwesomeIcon(name: .map, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
        setupDate()
    }

    var phone1:String{
        let phone1 = phonetxt.text
        return phone1!
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setupDate(){
        usertxt.delegate = self
        fullnametxt.delegate = self
        addresstxt.delegate = self
        emailtxt.delegate = self
        phonetxt.delegate = self
        if let user = userupdate.object(forKey: "user") {
            
            userget = SigninModel(dic: user as! Dictionary<String,Any>)
            avatarImg.loadImageurl(link: userget.avatar)
            usertxt.text = userget.username
            fullnametxt.text = userget.fullname
            emailtxt.text = userget.email
            phonetxt.text = userget.phone
            addresstxt.text = userget.address
            
            
        }
        let update = UIBarButtonItem(title: "Complete", style: .plain, target: self, action: #selector(completeupdate))
        update.tintColor = UIColor.white
        if presented != nil{
            self.navigationItem.rightBarButtonItem = update
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selected = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatarImg.image = selected
        dismiss(animated: true, completion: nil)
    }

    func completeupdate(){
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        if emailTest.evaluate(with: emailtxt.text) == false {
            let alert = UIAlertController(title: "Thong Bao", message: "Email Khong Dung Vui Long Nhap Lai", preferredStyle: .alert)
            let act = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(act)
            present(alert, animated: true, completion: nil)
            
        }
        if phone1.characters.count < 9 && phone1.characters.count > 11{
            let alert1 = UIAlertController(title: "Thong Bao", message: "SDT Khong Dung Vui Long Nhap Lai", preferredStyle: .alert)
            let act1 = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert1.addAction(act1)
            present(alert1, animated: true, completion: nil)
            
        }

        else{
        uploadSigup(link: "http://api.perfectpropertyvn.com/user/update")
        }
    }
    func uploadSigup(link:String){
        let img = avatarImg.image
        let parameters = [
            "username":usertxt.text ?? "",
            "fullname":fullnametxt.text ?? "",
            "email":emailtxt.text ?? "",
            "phone":phonetxt.text ?? "",
            "address":addresstxt.text ?? "",
            "id":String(userget.id)

        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let image = UIImageJPEGRepresentation(img!, 0.1){
                multipartFormData.append(image, withName: "avatar", fileName: "avata.jpeg", mimeType: "image/jpeg")
                
            }
            for (key,value) in parameters{
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
        }, to: link) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    if let result = response.result.value as? Dictionary<String,Any>{
                        if result["message"] as! Int == 1{
                            self.userget = SigninModel(message: result["message"] as! Int, dic: result["data"] as! Dictionary<String, Any>)
                            let sigup = self.userget.toDic(log: self.userget)
                            UserDefaults.standard.set(sigup, forKey: "user")
                            self.delegate?.updateSuccess(user: self.userget)
                            print("0000000\(self.userget.fullname)")
                            self.dismiss(animated: true, completion: nil)

                        }
                        else{
                            let alert = UIAlertController(title: "Update Khong Thanh Cong", message: result["note"] as? String, preferredStyle: UIAlertControllerStyle.alert)
                            let alertacation = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(alertacation)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                break
                
            case .failure(let err):
                print("loiroi\(err)")
                break
            }
        }
    }

}
