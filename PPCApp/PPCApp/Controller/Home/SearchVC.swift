//
//  SearchVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class SearchVC: BaseVC, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var searchs = [HomeDataModel]()
    var indexPage: Int = 1
    var nextPage: String = ""
    var textSearch:String?
    
    override func viewDidLoad() {
        collectionSearchResult.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        textFieldSearch.addTarget(self, action: #selector(textFielDidChange(_:)), for: .editingChanged)
        super.viewDidLoad()
        title = "Search"
    }
    lazy var collectionSearchResult : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    lazy var textFieldSearch : UITextField = {
        let tF = UITextField()
        tF.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        tF.placeholder = "Search"
        tF.returnKeyType = .search
        tF.delegate = self
        return tF
    }()
    let buttonMic : UIButton = {
        let bt = UIButton(type: UIButtonType.custom)
        bt.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        bt.setTitle(String.fontAwesomeIcon(name: .microphone), for: .normal)
        bt.setTitleColor(UIColor.navigationBar(), for: .normal)
        bt.addTarget(self, action: #selector(handleButtonMic(_:)), for: .touchUpInside)
        return bt
        
    }()
    override func setupView() {
        super.setupView()
        let labelSearchIcon = UILabel()
        labelSearchIcon.font = UIFont.fontAwesome(ofSize: 20)
        labelSearchIcon.text = String.fontAwesomeIcon(name: .search)
        labelSearchIcon.textAlignment = .center
        labelSearchIcon.textColor = UIColor.lightGray

        view.addSubview(labelSearchIcon)
        view.addSubview(textFieldSearch)
        view.addSubview(buttonMic)
        view.addSubview(collectionSearchResult)
        
        view.addConstraintWithFormat(format: "V:|[v0(40)][v1]|", views: textFieldSearch, collectionSearchResult)
        view.addConstraintWithFormat(format: "H:|[v0(40)][v1][v2(40)]|", views: labelSearchIcon, textFieldSearch, buttonMic)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionSearchResult)
        labelSearchIcon.centerYAnchor.constraint(equalTo: textFieldSearch.centerYAnchor, constant: 0).isActive = true
        
        buttonMic.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        buttonMic.centerYAnchor.constraint(equalTo: textFieldSearch.centerYAnchor, constant: 0).isActive = true
    }
    
    func handleButtonMic (_ sender : UIButton){
        self.view.endEditing(true)
        let speechLauncher = SpeechLauncher()
        speechLauncher.show()
        print("handleButtonMic")
    }
    
    func handleSearch(text: String){
        self.textSearch = text
        HomeService.shared.fetchHomesSearch(textSearch: textSearch!,indexPgae: indexPage) { (searchs, errMess, currentPage, next_page_url) in
            self.indexPage = currentPage
            self.nextPage = next_page_url
            self.searchs = searchs
            self.collectionSearchResult.reloadData()
        }
        print("Searching with text \(text)")
    }
    
    //MARK: - textFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFielDidChange(_ textField : UITextField){
        handleSearch(text: textField.text!)
    }
    
    //MARK: - CollectionViewDelegate
    let cellId = "cellId"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return searchs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        cell.home = searchs[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = view.frame.size.width * 9 / 16 + 80
        return CGSize(width: view.frame.size.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetailVC = PostDetailVC()
        postDetailVC.home = searchs[indexPath.item]
        present(viewController: postDetailVC)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.item
        if index == searchs.count - 1{
            if self.nextPage != ""{
                HomeService.shared.fetchHomesSearch(textSearch: textSearch!,indexPgae: indexPage + 1) { (mSearchs, errMess, currentPage, next_page_url) in
                    self.indexPage = currentPage
                    self.nextPage = next_page_url
                    self.searchs = self.searchs + mSearchs
                    self.collectionSearchResult.reloadData()
                }
                
            }
        }
    }
}
