//
//  HomeCell.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

@objc protocol PostVCDelegate {
    //@objc optional func seleted(index : IndexPath)
    @objc optional func seleted(home : HomeDataModel)
}
class HomeCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var indexPage: Int = 1
    var nextPage: String = ""
    var homes = [HomeDataModel]()
    
    var type : Int?{
        didSet{
            if type == 0{
                fetchSale(type: type!)
            }else{
                fetchRent(type: type!)
            }
        }
    }
    var delegate : PostVCDelegate?
    lazy var collectionViewPost : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    func fetchSale(type: Int){
        HomeService.shared.getHomes(indexPage: String(indexPage), type: type) { (mhomes, currentPage, next_page_url) in
            self.indexPage = currentPage
            self.nextPage = next_page_url
            self.homes = mhomes!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.collectionViewPost.reloadData()
            }
        }
    }
    func fetchRent(type: Int){
        HomeService.shared.getHomes(indexPage: String(indexPage), type: type) { (mhomes, currentPage, next_page_url) in
            self.indexPage = currentPage
            self.nextPage = next_page_url
            self.homes = mhomes!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.collectionViewPost.reloadData()
            }
        }
    }
    override func setupView() {
        collectionViewPost.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionViewPost)
        addConstraintWithFormat(format: "V:|[v0]-40-|", views: collectionViewPost)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewPost)
    }
    
    // MARK: - collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        cell.home = self.homes[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = self.frame.size.width * 9 / 16 + 80
        return CGSize(width: self.frame.size.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil{
            let home = homes[indexPath.row]
            self.delegate?.seleted!(home: home)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == homes.count - 1{
            if self.nextPage != ""{
                HomeService.shared.getHomes(indexPage: String(indexPage + 1), type: type!) { (mhomes, currentPage, next_page_url) in
                    self.indexPage = currentPage
                    self.nextPage = next_page_url
                    self.homes = self.homes + mhomes!
                    self.collectionViewPost.reloadData()
                }
                
            }
        }
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
    }
}
