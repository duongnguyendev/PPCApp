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
    var partnerss = [PartnersDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Partners"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PartnersCell", bundle: nil), forCellReuseIdentifier: "PartnersCell")
        
        self.view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        PartnersService.shared.getPartnersdata(indexpage: "") { (partners) in
            self.partnerss = partners
            print("sdsdsds\(self.partnerss[1].name)")
            self.tableView.reloadData()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
   }
extension PartnersVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partnerss.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell") as! PartnersCell
        //cell.partners = partnerss[indexPath.row]
        cell.logoImage.loadImageurl(link: partnerss[indexPath.row].image)
        cell.companyLabel.text = partnerss[indexPath.row].name
        print("aaaaaa\(partnerss[indexPath.row].link)")
        cell.fieldLabel.text = partnerss[indexPath.row].link
        return cell
    }
}
