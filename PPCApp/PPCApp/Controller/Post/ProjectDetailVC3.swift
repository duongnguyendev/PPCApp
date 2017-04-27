//
//  ProjectDetailVC3.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/24/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import Photos
class ProjectDetailVC3: BaseVC {
    let margin : CGFloat = 20.0
    let imageController = UIImagePickerController()
    
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView : UIView = {
        //content all view
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let buttonProjectPicture: GeneralButton = {
        let button = GeneralButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(handleProjectPictureButton(_:)), for: .touchUpInside)
        return button
    }()
    let imageViewProject : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "vinpearl"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let buttonProjectDetailPicture: GeneralButton = {
        let button = GeneralButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(handleProjectPictureDetailButton(_:)), for: .touchUpInside)
        return button
        
    }()
    lazy var collectionViewImage : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    let buttonPlanPicture: GeneralButton = {
        let button = GeneralButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(handlePlanPictureButton(_:)), for: .touchUpInside)
        return button
        
    }()
    let imageViewPlan : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "vinpearl"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let buttonPost : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePostButton(_:)), for: .touchUpInside)
        button.setTitle("Post Project", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.navigationBar()
        button.layer.borderWidth = 2
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Project"
        collectionViewImage.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        //let imageData:NSData = UIImagePNGRepresentation(UIImage(named: "vinpearl")!) as! NSData
        //let strBase64 = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        //print("Base 64\(strBase64)")
    }
    override func setupView() {
        super.setupView()
        
        setupMainScrollView()
        setupContentView()
        setupComponentsView()
    }
    
    func setupMainScrollView(){
        view.addSubview(mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func setupContentView(){
        self.mainScrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupComponentsView(){
        contentView.addSubview(buttonProjectPicture)
        contentView.addSubview(imageViewProject)
        contentView.addSubview(buttonProjectDetailPicture)
        contentView.addSubview(collectionViewImage)
        contentView.addSubview(buttonPlanPicture)
        contentView.addSubview(imageViewPlan)
        contentView.addSubview(buttonPost)
        
        setupProjectPictureView()
        setupProjectPictureDetailView()
        setupPlanPictureView()
        setupButtonPostView()
    }
    
    func setupProjectPictureView(){
        buttonProjectPicture.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonProjectPicture)
        buttonProjectPicture.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let height = view.frame.size.width * 9/16
        imageViewProject.topAnchor.constraint(equalTo: buttonProjectPicture.bottomAnchor, constant: 2).isActive = true
        imageViewProject.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        imageViewProject.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        imageViewProject.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupProjectPictureDetailView(){
        buttonProjectDetailPicture.topAnchor.constraint(equalTo: imageViewProject.bottomAnchor, constant: 2).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonProjectDetailPicture)
        buttonProjectDetailPicture.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionViewImage.topAnchor.constraint(equalTo: buttonProjectDetailPicture.bottomAnchor, constant: 2).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewImage)
        collectionViewImage.heightAnchor.constraint(equalToConstant: view.frame.size.width/2).isActive = true
    }
    
    func setupPlanPictureView(){
        buttonPlanPicture.topAnchor.constraint(equalTo: collectionViewImage.bottomAnchor, constant: 2).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonPlanPicture)
        buttonPlanPicture.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let height = view.frame.size.width
        let width = view.frame.size.width
        imageViewPlan.topAnchor.constraint(equalTo: buttonPlanPicture.bottomAnchor, constant: 2).isActive = true
        imageViewPlan.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageViewPlan.heightAnchor.constraint(equalToConstant: height).isActive = true
        imageViewPlan.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }
    func setupButtonPostView(){
        buttonPost.topAnchor.constraint(equalTo: imageViewPlan.bottomAnchor, constant: 40).isActive = true
        buttonPost.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonPost.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonPost.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    //Click Button
    func handleProjectPictureButton(_ sender: UIButton){
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        present(imageController, animated: true, completion: nil)
    }
    
    func handleProjectPictureDetailButton(_ sender: UIButton){
        let photoVC = PhotoVC()
        present(viewController: photoVC)
        print("Project Picture Detail Handle")
    }
    
    func handlePlanPictureButton(_ sender: UIButton){
        print("Project Plan Picture Handle")
    }
    
    func handlePostButton(_ sender: UIButton){
        print("Post Handle")
    }
}
extension ProjectDetailVC3: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.detailImage.image = UIImage(named: "vinpearl")
        //cell.detailImage.loadImageUsingUrlString(urlString: home.images[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/4 - 0.5, height: view.frame.size.width/4 - 0.5)
    }

}
extension ProjectDetailVC3: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let projectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageViewProject.image = projectImage
        
        self.dismiss(animated: true, completion: nil)
    }
}
