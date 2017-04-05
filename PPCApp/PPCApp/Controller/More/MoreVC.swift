//
//  MoreVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class MoreVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    var mores = [MoreDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More"
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
        MoreService.shared.getMores { (mores) in
            self.mores = mores
            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
        case 5:
            let projectVC = ProjectManagerVC()
            present(viewController: projectVC)
        default:
            break;
        }
    }
    
}
