//
//  MoreVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
var Login:Bool = false
class MoreVC: BaseVC,SuccessLogin {
    
//   let signupaa = SignupVC()
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var signImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarButton: UIButton!
    let getuser:UserDefaults = UserDefaults()
    //var user:SigninModel = SigninModel()
    var mores = [MoreDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
         signImage.layer.cornerRadius = 40
        signImage.clipsToBounds = true
        // Do any additional setup after loading the view.
        title = "More"

//        signupaa.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
        MoreService.shared.getMores { (mores) in
            self.mores = mores
            self.tableView.reloadData()
        }
        
       //login()
       
    }
   
    func getUser(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)
        
    }
    func signUpSuccess(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)

    }
    func getusersignup(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)
    }
//    func login(){
//        if Login == true{
//         let user = getuser.object(forKey: "user") as? [String:Any]
////        if user?["message"] as! Int == 1{
////        print("avatalol\(user?["avata"] as! String)")
////            self.signImage.loadImageurl(link: user?["avata"] as! String)
////
////            
////        }
//        
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func avatarHandle(_ sender: Any) {
        if Login == false{
        let signin = SignInVC()
        signin.delegate = self
        
        present(viewController: signin)
            //push(viewController: signin)
        }
        else{
            let profile = Profile()
            
            present(viewController: profile)
        }
    }
    

}
extension MoreVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell") as! MoreCell
        cell.more = mores[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            //Present Detail Recruitment
            let recruitmentVC = RecruitmentVC()
            present(viewController: recruitmentVC)
        case 1:
            //Present Detail Partners
            let partnersVC = PartnersVC()
            present(viewController: partnersVC)
        case 2:
            //Present Introduction PPC
            let aboutVC = AboutVC()
            present(viewController: aboutVC)
        case 3:
            //Present Detail Terms
            let termsVC = TermsVC()
            present(viewController: termsVC)
        case 4:
            //Present Detail Setting
            let settingVC = SettingVC()
            present(viewController: settingVC)
        default:
            break;
        }
    }
    
}
