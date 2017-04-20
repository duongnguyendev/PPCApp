//
//  TermsVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class TermsVC: BaseVC {
    
    
    @IBOutlet weak var tblTerms: UITableView!
    var Termss = [TermsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms"
        tblTerms.delegate = self
        tblTerms.dataSource = self
        let nib = UINib(nibName: "TermsCell", bundle: nil)
        tblTerms.register(nib, forCellReuseIdentifier: "TermCell")
        self.tblTerms.separatorStyle = .none
        tblTerms.rowHeight = UITableViewAutomaticDimension
        tblTerms.estimatedRowHeight = 140
        TermsService.share.getTermsData(indexpage: "") { (termss) in
            self.Termss = termss
            self.tblTerms.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
extension TermsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Termss.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermCell", for: indexPath) as! TermsCell
        if indexPath.row == 0{
            cell.title.textAlignment = .center
        }
        else{
            cell.title.textAlignment = .left
        }
        cell.term = Termss[indexPath.row]
        return cell
    }
}
