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
class Signup: BaseVC,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

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
    
    
    @IBOutlet weak var completebtn: UIButton!
    @IBAction func Acompletebtn(_ sender: Any) {
       uploadSigup(link: "http://api.perfectpropertyvn.com/vi/user/create")
    }
    

    var avataImage:UIImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SignUp"
        
        emailtxt.delegate = self
        address.delegate = self
        phonetxt.delegate = self
        fullnametxt.delegate = self
        avataImg.layer.cornerRadius = 60
        avataImg.clipsToBounds = true
        avataImg.image = UIImage.fontAwesomeIcon(name: .camera, textColor: .darkGray, size: CGSize(width: 120, height: 120))
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        passImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        repassImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .laptop, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: UIColor.darkGray, size: CGSize(width: 40, height: 40))
        adressImage.image = UIImage.fontAwesomeIcon(name: .map, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        
        
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selected = info[UIImagePickerControllerOriginalImage] as! UIImage
        avataImg.image = selected
        avataImage = selected
        dismiss(animated: true, completion: nil)
    }
    func uploadSigup(link:String){
        let img = UIImage(named: "down")
        let parameters = [
            "username":usertxt.text,
            "password":passtxt.text,
            "fullname":fullnametxt.text,
            "email":emailtxt.text,
            "phone":phonetxt.text,
            "address":address.text
        ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let image = UIImageJPEGRepresentation(img!, 1){
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
                    print("ppppppppp\(response.result.value as Any)")
                }
                break

            case .failure(let err):
                print("loiroi\(err)")
                break
            }
                    }
    }
}



