//
//  PhotoVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/26/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
@objc protocol ProjectDetailVC3Delegate {
    @objc optional func ChooseImages(images : [UIImage])
}

class PhotoVC: BaseVC{
    var chooseImages = [UIImage]()
    var delegate: ProjectDetailVC3Delegate?
    
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
        collectionViewImage.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        PhotoHandle.shared.fetchPhotos{ (images) in
            self.images = images
            collectionViewImage.reloadData()
        }
    }
    override func setupView() {
        super.setupView()
        addCompleteButton()
        view.addSubview(collectionViewImage)
        collectionViewImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionViewImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionViewImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionViewImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func addCompleteButton(){
        let filterButton = UIBarButtonItem(title: "Complete", style: .done, target: self, action: #selector(handleCompleteButton(_:)))
        filterButton.customTitle()
        self.navigationItem.rightBarButtonItem = filterButton
    }
    func handleCompleteButton(_ sender: UIBarButtonItem){
        if self.delegate != nil{
            self.delegate?.ChooseImages!(images: chooseImages)
            self.goBack()
        }
    }
}
extension PhotoVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.buttonPhoto.bgrImage = images[indexPath.item]
        cell.buttonPhoto.tag = indexPath.item
        cell.delegate = self
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
extension PhotoVC: PhotoVCDelegate{
    func selected(sender: ChoosePhoto) {
        let image = sender.bgrImage
        if sender.isSelected{
            chooseImages.append(image!)
        }else{
            let index = chooseImages.index(of: sender.bgrImage)
            chooseImages.remove(at: index!)
        }
    }
}
