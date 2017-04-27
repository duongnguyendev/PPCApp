//
//  PhotoVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/26/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PhotoVC: BaseVC{
    
    lazy var collectionViewImage : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Library"
        collectionViewImage.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        
        PostService.shared.fetchPhotos { (images) in
            self.images = images
            collectionViewImage.reloadData()
            print("Images\(images.count)")
        }
    }
    override func setupView() {
        super.setupView()
        view.addSubview(collectionViewImage)
        
        collectionViewImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionViewImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionViewImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionViewImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
extension PhotoVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.detailImage.image = images[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3 - 0.5, height: view.frame.size.width/3 - 0.5)
    }

}
