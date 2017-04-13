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
    let indexPage: Int = 1
    var news = [NewDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        NewService.shared.getNew(indexPage: String(indexPage)) { (new) in
            if let new = new{
                self.news.append(new)
                self.tableView.reloadData()
            }
        }
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
extension NewsVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news.count == 0{
            return 0
        }else{
            return news[indexPage - 1].datas.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell") as! NewCell
        cell.data = news[indexPage - 1].datas[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailNew = DetailNewVC()
        present(viewController: detailNew)
    }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //use text height of desc
        /*let size = CGSize(width: frame.width - margin - margin - 10, height: 1000)
         let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
         let text = resorts[indexPath.item].introduce
         let estimatedRect = NSString(string: text!).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.init(name: "Roboto-Medium", size: 14) as Any], context: nil)*/
        //print("Height TableView: \(view.frame.width * 9 / 16 + 80)")
        //print("Height Screen: \(view.frame.width * 9 / 16)")
        return CGFloat(view.frame.width * 9 / 16 + 90)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }

}
