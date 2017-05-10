//
//  AboutVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class AboutVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var abouts = [AboutDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AboutCell", bundle: nil), forCellReuseIdentifier: "AboutCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

    }
    override func viewDidAppear(_ animated: Bool) {
        MoreService.shared.getAbouts { (mAbouts) in
            if mAbouts != nil{
                self.abouts = mAbouts!
                self.tableView.reloadData()
            }
        }
    }
    
}
extension AboutVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abouts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
        cell.about = abouts[indexPath.row]
        return cell
    }

}
