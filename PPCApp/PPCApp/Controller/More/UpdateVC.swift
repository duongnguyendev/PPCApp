//
//  UpdateVC.swift
//  PPCApp
//
//  Created by NguoiNb on 4/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class UpdateVC: BaseVC {

    
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

   
}
