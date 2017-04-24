//
//  ImageDetailLauncher.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
class ImageDetailLauncher: BaseLauncher {
    let cellId = "cellId"
    /*let imageShow: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()*/
    var images = [String](){
        didSet{
            self.cvImageDetail.reloadData()
        }
    }
//  var indexItem: IndexPath?
    
    lazy var cvImageDetail : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    let buttonClose : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.setTitle("Close", for: .normal)
        
        return button
    }()
    
    override func setupContent() {
        self.height = windowFrame.size.height
        buttonClose.addTarget(self, action: #selector(handleCloseButton(_:)), for: .touchUpInside )
        super.setupContent()
        contentView.frame = windowFrame
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        cvImageDetail.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        contentView.addSubview(cvImageDetail)
        contentView.addSubview(buttonClose)
        //contentView.addSubview(imageShow)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: cvImageDetail)
        contentView.addConstraintWithFormat(format: "V:|-64-[v0]-64-|", views: cvImageDetail)
        contentView.addConstraintWithFormat(format: "H:|[v0(60)]", views: buttonClose)
        contentView.addConstraintWithFormat(format: "V:|-20-[v0(30)]", views: buttonClose)
    }
    
    func handleCloseButton(_ sender: UIButton){
        self.close()
    }
    
    override func close() {
        super.close()
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.contentView.alpha = 0
        }) { (Bool) in
            
        }
    }
    override func show() {
        super.show()
        UIView.animate(withDuration: 0.5, animations: { 
            self.contentView.alpha = 1
        }) { (Bool) in
            
        }
    }
    func show(index : IndexPath)
    {
        self.show()
        
        self.cvImageDetail.scrollToItem(at: index, at: .left, animated: true)
    }
}

extension ImageDetailLauncher: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        cell.detailImage.contentMode = .scaleAspectFit
        cell.detailImage.loadImageUsingUrlString(urlString: images[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let cellHeight = self.frame.size.width * 9 / 16 + 80
        return CGSize(width: cvImageDetail.frame.width, height: cvImageDetail.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
