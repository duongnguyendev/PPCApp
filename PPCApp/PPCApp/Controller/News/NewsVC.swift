//
//  NewsVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
class NewsVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    var news = [NewDataModel]()
    var indexPage: Int = 1
    var nextPage: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "news")
        NewService.shared.getNews(indexPage: indexPage) { (news, error, currentPage, next_page_url) in
            if error == 1{
                self.indexPage = currentPage!
                self.nextPage = next_page_url!
                self.news = news!
                self.tableView.reloadData()
            }
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.indexPage = 1
        self.nextPage = ""
    }
}
extension NewsVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell") as! NewCell
        cell.new = news[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newDetailVC = NewDetailVC()
        newDetailVC.new = news[indexPath.row]
        present(viewController: newDetailVC)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //use text height of desc
        /*let size = CGSize(width: frame.width - margin - margin - 10, height: 1000)
         let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
         let text = resorts[indexPath.item].introduce
         let estimatedRect = NSString(string: text!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.init(name: "Roboto-Medium", size: 14) as Any], context: nil)*/
        return CGFloat(view.frame.width * 9 / 16 + 90)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == news.count - 2{
            if self.nextPage != ""{
                NewService.shared.getNews(indexPage: self.indexPage + 1) { (news, error,currentPage, next_page_url) in
                    self.indexPage = currentPage!
                    self.nextPage = next_page_url!
                    self.news = self.news + news!

                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
