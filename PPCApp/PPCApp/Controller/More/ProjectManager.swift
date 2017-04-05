//
//  ProjectManager.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ProjectManagerVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Project Manager"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PMCell", bundle: nil), forCellReuseIdentifier: "PMCell")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
extension ProjectManagerVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PMCell") as! PMCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(view.frame.width * 9 / 16 + 165)
        
    }

}
