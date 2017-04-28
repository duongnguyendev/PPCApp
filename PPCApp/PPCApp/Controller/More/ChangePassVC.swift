//
//  ChangePassVC.swift
//  PPCApp
//
//  Created by NguoiNb on 4/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ChangePassVC: BaseVC {
    
    
    var usercurrent:SigninModel = SigninModel()
    @IBOutlet weak var oldpassImg: UIImageView!
    @IBOutlet weak var newpassImg: UIImageView!
    @IBOutlet weak var confirmoassImg: UIImageView!
    
    @IBOutlet weak var oldpasstxt: UITextField!
    @IBOutlet weak var newpasstxt: UITextField!
    @IBOutlet weak var confirmpasstxt: UITextField!
  
   
    override func viewDidLoad() {
        super.viewDidLoad()

        oldpassImg.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        newpassImg.image = UIImage.fontAwesomeIcon(name: .lock, textColor: .darkGray, size: CGSize(width: 40, height: 40))
        let complete = UIBarButtonItem(title: "Complete", style: .plain, target: self, action: #selector(acomplete))
        complete.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if presented != nil{
            self.navigationItem.rightBarButtonItem = complete
        }
    }
    func acomplete(){
        if newpasstxt.text != confirmpasstxt.text{
            let alert = UIAlertController(title: "Thong Bao", message: "Xac nhan lai pass word", preferredStyle: .alert)
            let act = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(act)
            present(alert, animated: true, completion: nil)
        }
        else{
            let userdf:UserDefaults = UserDefaults()
            usercurrent = SigninModel(dic: userdf.object(forKey: "user") as! Dictionary<String,Any>)
            let param = ["id":usercurrent.id,"password_old":oldpasstxt.text ?? "","password_new":newpasstxt.text ?? ""] as [String : Any]
            let post:BaseService = BaseService()
            post.apiService.posturl(url: "http://api.perfectpropertyvn.com/user/changepass", parameters: param, completion: { (jsons, err) in
                let json = jsons
                if json?["message"].int == 1{
                    let alert2 = UIAlertController(title: "Thong Bao", message: "Doi PassWord Thanh Cong", preferredStyle: .alert)
                    let act = UIAlertAction(title: "Ok", style: .default, handler: { (ac) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alert2.addAction(act)
                    self.present(alert2, animated: true, completion: nil)
                }
                else{
                    
                   
                    
                    let alert1 = UIAlertController(title: "Thong Bao", message: "That Bai", preferredStyle: .alert)
                    let act = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert1.addAction(act)
                    self.present(alert1, animated: true, completion: nil)

                }
                
            })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
