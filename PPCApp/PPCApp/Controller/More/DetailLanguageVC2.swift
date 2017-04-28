//
//  DetailLanguageVC2.swift
//  PPCApp
//
//  Created by NguoiNb on 4/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class DetailLanguageVC2: BaseVC {

    let arr = ["Tieng Viet","English"]
    @IBOutlet weak var TblLanguage: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

                TblLanguage.delegate = self
                TblLanguage.dataSource =  self
                let nib = UINib(nibName: "Celllanguage", bundle: nil)
                TblLanguage.register(nib, forCellReuseIdentifier: "Celllanguage")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension DetailLanguageVC2:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celllanguage", for: indexPath) as! Celllanguage
        cell.textLabel?.text = arr[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
//            let language:Language = Language(languageCode: "", language: <#T##String#>)
//            LanguageManager.shared.setCurrent(language: <#T##Language#>)
        }
        
        
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            // Note: Programmatically deslecting does NOT invoke tableView(:didSelectRowAt:), so no risk of infinite loop.
            tableView.deselectRow(at: selectedIndex, animated: false)
            // Remove the visual selection indication.
            tableView.cellForRow(at: selectedIndex)?.accessoryType = .none
        }
        return indexPath
    }
}
