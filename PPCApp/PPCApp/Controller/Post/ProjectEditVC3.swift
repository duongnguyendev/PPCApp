//
//  ProjectEditVC3.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/31/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import Photos
class ProjectEditVC3: BaseVC {
    
    var post = HomeDataModel()
    var images = [UIImage]()
    let margin : CGFloat = 20.0
    let imageController = UIImagePickerController()
    var type: Int?
    var imgProjectData: Data?
    var imgPlanData: Data?
    var imgDetailData: [Data]?
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
    let buttonProjectPicture: GeneralPost = {
        let button = GeneralPost(type: UIButtonType.custom)
        button.name = LanguageManager.shared.localized(string: "projectPicture")
        button.addTarget(self, action: #selector(handleProjectPictureButton(_:)), for: .touchUpInside)
        return button
    }()
    let imageViewProject : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "vinpearl"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let buttonProjectDetailPicture: GeneralPost = {
        let button = GeneralPost(type: UIButtonType.custom)
        button.name = LanguageManager.shared.localized(string: "detailPicture")
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
    let buttonPlanPicture: GeneralPost = {
        let button = GeneralPost(type: UIButtonType.custom)
        button.name = LanguageManager.shared.localized(string: "planPicture")
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
        button.setTitle(LanguageManager.shared.localized(string: "postproject"), for: .normal)
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
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        imageViewProject.loadImageUsingUrlString(urlString: post.image)
        imageViewPlan.loadImageUsingUrlString(urlString: post.image_overall)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "postproject")
        self.parseData(link: post.image, completion: { (data, error) in
            self.imgProjectData = data
        })
        self.parseData(link: post.image_overall, completion: { (data, error) in
            self.imgPlanData = data
        })
    }
    func parseData(link: String,completion:@escaping ((Data?,Error?)->())){
        let url = URL(string: link)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            completion(data,nil)
        }
        task.resume()
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
        buttonPost.topAnchor.constraint(equalTo: imageViewPlan.bottomAnchor, constant: 20).isActive = true
        buttonPost.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonPost.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonPost.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    //Click Button
    func handleProjectPictureButton(_ sender: UIButton){
        self.type = 0
        present(imageController, animated: true, completion: nil)
    }
    func handleProjectPictureDetailButton(_ sender: UIButton){
        let photoVC = PhotoVC()
        photoVC.delegate = self
        present(viewController: photoVC)
    }
    func handlePlanPictureButton(_ sender: UIButton){
        self.type = 1
        present(imageController, animated: true, completion: nil)
    }
    func handlePostButton(_ sender: UIButton){
        if checkImageProjectVC3(){
            if post.lang == ""{
                ProjectService.shared.postProject(post: post) { (errMess) in
                    if errMess == 1{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "incorrect_postproject")!)
                    }
                }
                
            }else{
                ProjectService.shared.updateProject(post: post) { (errMess) in
                    if errMess == 1{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "incorrect_postproject")!)
                    }
                }
            }
            
        }else{
            self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "message_inputinfo")!)
        }
    }
    func checkImageProjectVC3()->Bool{
        if imgProjectData == nil || imgPlanData == nil{
            return false
        }
        post.fileImage = imgProjectData
        post.fileImage_overall = imgPlanData
        post.fileMultiImage = imgDetailData
        return true
    }
    func showAlertController(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resizePhotoLibrary(images: [UIImage],completion: ([Data]?)->Void){
        var data = [Data]()
        for index in 0..<images.count{
            let imgData = UIImageJPEGRepresentation(images[index], 0.1)
            data.append(imgData!)
        }
        completion(data)
    }
}
extension ProjectEditVC3: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if post.images.count > 0{
            return post.images.count
        }
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        if post.images.count > 0{
            cell.detailImage.loadImageUsingUrlString(urlString: post.images[indexPath.item])
        }else{
            cell.detailImage.image = images[indexPath.item]
        }
        
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
extension ProjectEditVC3: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imgProject = info[UIImagePickerControllerOriginalImage] as! UIImage
        if type == 0{
            imageViewProject.image = imgProject
            self.imgProjectData = UIImageJPEGRepresentation(imgProject, 0.1)
        }else{
            imageViewPlan.image = imgProject
            self.imgPlanData = UIImageJPEGRepresentation(imgProject, 0.1)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
extension ProjectEditVC3: ProjectDetailVC3Delegate{
    func ChooseImages(images: [UIImage]) {
        self.post.images.removeAll()
        self.images = images
        self.collectionViewImage.reloadData()
        resizePhotoLibrary(images: images) { (data) in
            self.imgDetailData = data
        }
    }
}
