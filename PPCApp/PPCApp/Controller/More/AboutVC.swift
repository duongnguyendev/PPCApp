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
    
    
    @IBOutlet weak var tblAboutus: UITableView!
    
    @IBOutlet weak var viewbackground: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    var AboutusDatas = [AboutusDataModels]()
    
    @IBOutlet weak var lbl: UILabel!
    var indexpath:Int = -1
    var tag:Int = -1
    var hieghtcell:CGFloat = 0
    var click:Bool = false
    var sttcontent:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About PPC"
        tblAboutus.delegate = self
        tblAboutus.dataSource = self
        activity.startAnimating()
        let nib:UINib = UINib(nibName: "AboutusCell", bundle: nil)
        tblAboutus.register(nib, forCellReuseIdentifier: "Cell")
        AboutusService.share.getDataService(indexpage: "") { (AboutusDatas) in
            self.AboutusDatas = AboutusDatas

            self.tblAboutus.reloadData()
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.viewbackground.isHidden = true
            self.lbl.isHidden = true
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        aboutTextView.text = LanguageManager.shared.localized(string: "about_desc")
    }
    func htmlcoverString(string:String)->String{
        let encodeData = string.data(using: String.Encoding.utf8)!
        do{
            return try NSAttributedString(data: encodeData, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil).string
        }
        catch let error as NSError
            
        {
            print(error.localizedDescription)
            return  " "
        }
    }

}
extension AboutVC:UITableViewDelegate,UITableViewDataSource{
    func loadmore(sender:UIButton){
        indexpath = sender.tag
        click = !click
        if click{
            self.tblAboutus.reloadData()
            
        }
        else{
            self.tblAboutus.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AboutusDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AboutusCell
        cell.moreButton.tag = indexPath.row
        cell.titleLabel.text = AboutusDatas[indexPath.row].title
        let string:String = AboutusDatas[indexPath.row].content
                string.htmlAttributedString { (stt) in
            cell.contentLable.attributedText = stt
        }
//        var stt:String = ""
//        string.htmlAttributedString { (string) in
//            string = stt
//        }
        //cell.contentLable.text =  sttcontent[indexPath.row]
       // cell.contentLable.text = AboutusDatas[indexPath.row].content
        cell.contentLable.numberOfLines = 0
        cell.contentLable.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.contentLable.font = UIFont(name: "Helvetica", size: 15.0)
        cell.contentLable.sizeToFit()
        hieghtcell = cell.contentLable.frame.height

        
        cell.moreButton.addTarget(self, action: #selector(loadmore(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == indexpath{
            
            return hieghtcell + 30
        }
        else{
            return 30
        }
    }
}
