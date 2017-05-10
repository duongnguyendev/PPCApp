//
//  TermsVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/7/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class TermsVC: BaseVC{
    
    @IBOutlet weak var tableView: UITableView!
    var terms = [TermsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TermsCell", bundle: nil), forCellReuseIdentifier: "TermsCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

    }
    override func viewDidAppear(_ animated: Bool) {
        MoreService.shared.getTerms { (mTerms) in
            if mTerms != nil{
                self.terms = mTerms!
                self.tableView.reloadData()
            }
        }
    }
    
}
extension TermsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermsCell", for: indexPath) as! TermsCell
        cell.term = terms[indexPath.row]
        return cell
    }
}
