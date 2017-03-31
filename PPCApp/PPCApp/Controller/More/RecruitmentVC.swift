//
//  RecruitmentVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class RecruitmentVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recruitment"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RecruitmentCell", bundle: nil), forCellReuseIdentifier: "RecruitmentCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}
extension RecruitmentVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentCell") as! RecruitmentCell
        let index = String(indexPath.row)
        cell.positionLabel.text = "Recruitment " + index
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Click Select Index Recruitment
    }

}
