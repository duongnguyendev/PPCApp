//
//  DetailLanguageVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/5/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class LanguageVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var languages: [Language] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Language"
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "LanguageCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LanguageCell")
        
        self.languagesString()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func languagesString(){
        let en = Language(languageCode: "en", language: LanguageManager.shared.localized(string:"english")!)
        let vi = Language(languageCode: "vi", language: LanguageManager.shared.localized(string:"vietnamese")!)
        self.languages = [en, vi]
    }
}
extension LanguageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageCell
        cell.languageLabel.text = languages[indexPath.row].language
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            LanguageManager.shared.setCurrent(language: languages[indexPath.row])
            cell.accessoryType = .checkmark
            dismiss(animated: true, completion: nil)
        }
    }
}
