//
//  SettingVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/5/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class SettingVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
extension SettingVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Language"
            cell.languageLabel.isHidden = false
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            cell.titleLabel.text = "Sign out"
            cell.languageLabel.isHidden = true
            cell.accessoryType = .none
            return cell
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*if indexPath.row == 0{
            let detailVC = DetailLanguageVC()
            present(viewController: detailVC)
        }*/
    }
}
