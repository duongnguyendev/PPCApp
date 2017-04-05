//
//  HomeCell.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

@objc protocol PostVCDelegate {
    @objc optional func seleted(index : IndexPath)
}
class HomeCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var type : Int?{
        didSet{
            if type == 0{
                fetchSale()
            }else{
                fetchRent()
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
    
    func fetchSale(){
//        self.backgroundColor = UIColor.red
    }
    func fetchRent(){
//        self.backgroundColor = UIColor.blue
    }
    override func setupView() {
        collectionViewPost.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionViewPost)
        addConstraintWithFormat(format: "V:|[v0]-49-|", views: collectionViewPost)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewPost)
    }
    
    // MARK: - collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = self.frame.size.width * 9 / 16 + 80
        return CGSize(width: self.frame.size.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil{
            self.delegate?.seleted!(index: indexPath)
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
