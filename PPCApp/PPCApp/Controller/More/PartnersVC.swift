//
//  PartnersVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PartnersVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var partners = [PartnersDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Partners"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PartnersCell", bundle: nil), forCellReuseIdentifier: "PartnersCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        MoreService.shared.getPartners { (mPartners) in
            self.partners = mPartners!
            self.tableView.reloadData()
        }
    }
    
}
extension PartnersVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.partners.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell") as! PartnersCell
        //cell.partners = partnerss[indexPath.row]
        cell.partners = partners[indexPath.row]
        return cell
    }
}
