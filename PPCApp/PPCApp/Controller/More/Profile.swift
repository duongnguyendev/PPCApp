//
//  Profile.swift
//  PPCApp
//
//  Created by NguoiNb on 4/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Profile: BaseVC {

    var delegate:SuccessLogin?

    @IBOutlet weak var sroll: UIScrollView!
    
    @IBOutlet weak var AvataImg: UIImageView!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var usertxt: UITextField!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var phoneImg: UIImageView!
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var addressImg: UIImageView!
    @IBOutlet weak var addresstxt: UITextField!
    
    @IBOutlet weak var changepass: UIButton!
    
    @IBAction func Achangepass(_ sender: Any) {
        let change = ChangePassVC()
        //present(viewController: change)
        push(viewController: change)
    }
    
    var user:SigninModel = SigninModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        userImg.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: userImg.frame.width, height: userImg.frame.height))
        emailImg.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: emailImg.frame.width, height: emailImg.frame.height))
        phoneImg.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .darkGray, size: CGSize(width: phoneImg.frame.width, height: phoneImg.frame.height))
        addressImg.image = UIImage.fontAwesomeIcon(name: .map, textColor: .darkGray, size: CGSize(width: addressImg.frame.width, height: addressImg.frame.height))
        showProfile()
        AvataImg.layer.cornerRadius = (AvataImg.bounds.size.height / 2.0 - 20)
        AvataImg.clipsToBounds = true
        
        changepass.layer.cornerRadius = 3
        // Do any additional setup after loading the view.
     
    }

    func showProfile(){
    
        let userLogin:UserDefaults = UserDefaults()
        if userLogin.object(forKey: "user") != nil{
       // print("asassassss\(userLogin.object(forKey: "user") as! Dictionary<String,Any>)")
        user = SigninModel(dic: userLogin.object(forKey: "user") as! Dictionary<String, Any>)
        usertxt.text = user.fullname
        emailtxt.text = user.email
        phonetxt.text = user.phone
        addresstxt.text = user.address
        AvataImg.loadImageurl(link: user.avatar)
        }
        
    
        let update = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(goUpdate))
        update.tintColor = UIColor.white
        if presented != nil{
            self.navigationItem.rightBarButtonItem = update
        }
    }
    
    func goUpdate(){
        let update = UpdateVC()
        //present(viewController: update)
        update.delegate = self.delegate
       push(viewController: update)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    func keyboardWillShow(notification: NSNotification){
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
//            self.sroll.contentInset = contentInsets
//            self.sroll.scrollIndicatorInsets = contentInsets
//            var aRect = self.view.frame
//            aRect.size.height -= keyboardSize.size.height
//            //            if (!CGRectContainsPoint(aRect, keyboardSize.frame.origin)) {
//            //                self.scroll.scrollRectToVisible(keyboardSize.frame, animated: true)
//            //            }
//            
//        }
//    }
//    func keyboardWillBeHidden(notification: NSNotification) {
//        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        self.sroll.contentInset = contentInsets
//        self.sroll.scrollIndicatorInsets = contentInsets
//    }

}

