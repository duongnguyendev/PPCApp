//
//  PostDetailVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import MessageUI

class PostDetailVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MFMailComposeViewControllerDelegate {
    
    let margin : CGFloat = 20.0
    let cellId = "cellId"
    var home = HomeDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = home.title
        collectionViewImage.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        showInfoHome()
        collectionViewImage.reloadData()
    }
    
    func showInfoHome(){
        imageViewPoster.loadImageUsingUrlString(urlString: home.image)
        home.info.htmlAttributedString { (mInfo) in
            textViewdDescription.attributedText = mInfo
        }
        projectView.content = home.title
        investorsView.content = home.investor
        locationsView.content = home.address
        projectAreaView.content = ((home.acreage).description) + " m2"
        apartmentInfomationView.content = "Floors: \(((home.floor).description))\nBedrooms: \(((home.bedroom).description))\nBathrooms: \(((home.bathroom).description))"
        totalApartmentView.content = ((home.bedroom).description)
        home.service.htmlAttributedString { (mService) in
            convenientServicesView.content = mService?.string
        }
    }
    
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
    
    let imageViewPoster : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "vinpearl"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let buttonCall : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCallButton(_:)), for: .touchUpInside)
        button.setTitle("Call", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        button.setTitleColor(UIColor.title(), for: .normal)
        button.backgroundColor = UIColor.navigationBar()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    let buttonEmail : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEmailButton(_:)), for: .touchUpInside)
        button.setTitle("Mail", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        button.setTitleColor(UIColor.navigationBar(), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.navigationBar().cgColor
        button.layer.borderWidth = 2
        
        return button
    }()
    
    let textViewdDescription : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        textView.textAlignment = .justified
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
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
    
    let buttonGeneralLayout : GeneralButton = {
        let button = GeneralButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(handleGeneralLayoutButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let projectView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Project"
        view.content = "Seasons Avenue"
        return view
    }()
    let investorsView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Investors"
        view.content = "Novaland Group"
        return view
    }()
    let locationsView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Locations"
        view.content = "537 Nguy Duy Trinh, District 2, Ho Chi Minh City, VietNam"
        return view
    }()
    let formsOfPropertyView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Forms of property ownership"
        view.content = "Freehold for local Vietnamese, 50 years long term lease for foreignes"
        return view
    }()
    let projectAreaView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Project area"
        view.content = "40m2"
        return view
    }()
    let apartmentInfomationView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Apartmet infomation"
        view.content = "Floors: 2\nBedrooms: 2\nBathrooms: 1"
        return view
    }()
    let totalApartmentView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Total Apartments"
        view.content = "25 apartments"
        return view
    }()
    let convenientServicesView : PostDetailInfoView = {
        let view = PostDetailInfoView()
        view.title = "Convenient Services"
        view.content = "Swimming pool\nMulti-purpose hall\nGym\nOutdoor Family Corner\nPicnicLawn\nFood reflexology track\nChildren Playground\nBBQ Cabana"
        return view
    }()
    let imageLauncher = ImageDetailLauncher()
    
    //MARK: - Setup View
    override func setupView() {
        super.setupView()
        setupMainScrollView()
        setupcontentView()
        setupContentViewComponents()
    }
    func setupMainScrollView() {
        view.addSubview(mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupcontentView() {
        self.mainScrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
    }
    func setupContentViewComponents() {
        contentView.addSubview(imageViewPoster)
        contentView.addSubview(buttonCall)
        contentView.addSubview(buttonEmail)
        contentView.addSubview(textViewdDescription)
        contentView.addSubview(collectionViewImage)
        contentView.addSubview(buttonGeneralLayout)
        contentView.addSubview(projectView)
        contentView.addSubview(investorsView)
        contentView.addSubview(locationsView)
        contentView.addSubview(formsOfPropertyView)
        contentView.addSubview(projectAreaView)
        contentView.addSubview(apartmentInfomationView)
        contentView.addSubview(totalApartmentView)
        contentView.addSubview(convenientServicesView)
        
        setupPosterImageView()
        setupButton()
        setupTextViewDiscription()
        setupCollectionViewImage()
        setupGeneralLayoutView()
        setupProjectView()
        setupInvestorsView()
        setupLocationsView()
        setupFormsOfPropertyView()
        setupProjectAreaView()
        setupApartmentView()
        setupTotalView()
        setupConvenientServicesView()
    }
    
    func setupPosterImageView(){
        let height = view.frame.size.width * 9/16
        imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageViewPoster.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        imageViewPoster.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        imageViewPoster.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupButton() {
        let buttonHeight : CGFloat = 30.0
        contentView.addConstraint(NSLayoutConstraint(item: buttonCall, attribute: .width, relatedBy: .equal, toItem: buttonEmail, attribute: .width, multiplier: 1, constant: 0))
        // button call
        buttonCall.topAnchor.constraint(equalTo: imageViewPoster.bottomAnchor, constant: margin/2).isActive = true
        buttonCall.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        // button email
        
        buttonEmail.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        buttonEmail.centerYAnchor.constraint(equalTo: buttonCall.centerYAnchor, constant: 0).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-|", views: buttonCall, buttonEmail)
    }
    
    func setupTextViewDiscription() {
        let text = "Strategically located along the fringe of the city centre, PARCSpring enjoys easy accessibility to Thu Thiem Tunnel and the future Ho Chi Minh City-Long Thanh-Dau Giay Highway. PARCSpring offers extensive landscaping and communal facilities within a safe environment. The apartments are designed with a functional layout to maximise living space. The project comprise 394 residential apartments across two 18-storey and one 12-storey buildings.\nPARCSpring offers two and three-bedroom units, furnished in earthly tones for a pleasant living atmosphere with an open kitchen concept and a practical unit layout design."
        let size = CGSize(width: view.frame.width - margin - margin, height: 1000)
        let height = String.heightWith(string: text, size: size, font: textViewdDescription.font!)
        
        textViewdDescription.topAnchor.constraint(equalTo: buttonCall.bottomAnchor, constant: margin/2).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-\(margin - 5)-[v0]-\(margin - 5)-|", views: textViewdDescription)
        textViewdDescription.heightAnchor.constraint(equalToConstant: height + 20).isActive = true
        textViewdDescription.text = text
        
    }
    func setupCollectionViewImage() {
        collectionViewImage.topAnchor.constraint(equalTo: textViewdDescription.bottomAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: collectionViewImage)
        collectionViewImage.heightAnchor.constraint(equalToConstant: view.frame.size.width/2).isActive = true
    }
    
    func setupGeneralLayoutView(){
        buttonGeneralLayout.topAnchor.constraint(equalTo: collectionViewImage.bottomAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonGeneralLayout)
        buttonGeneralLayout.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupProjectView(){
        projectView.topAnchor.constraint(equalTo: buttonGeneralLayout.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: projectView)
        projectView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    func setupInvestorsView(){
        
        investorsView.topAnchor.constraint(equalTo: projectView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: investorsView)
        investorsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupLocationsView(){
        let text = "537 Nguy Duy Trinh, District 2, Ho Chi Minh City, VietNam"
        let size = CGSize(width: view.frame.width - margin - margin, height: 1000)
        let height = String.heightWith(string: text, size: size, font: locationsView.textViewContent.font!)
        
        locationsView.topAnchor.constraint(equalTo: investorsView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: locationsView)
        locationsView.heightAnchor.constraint(equalToConstant: 40 + height).isActive = true
    }
    func setupFormsOfPropertyView(){
        
        let text = "Freehold for local Vietnamese, 50 years long term lease for foreignes"
        let size = CGSize(width: view.frame.width - margin - margin, height: 1000)
        let height = String.heightWith(string: text, size: size, font: formsOfPropertyView.textViewContent.font!)
        
        formsOfPropertyView.topAnchor.constraint(equalTo: locationsView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: formsOfPropertyView)
        formsOfPropertyView.heightAnchor.constraint(equalToConstant: 40 + height).isActive = true
    }
    func setupProjectAreaView(){
        projectAreaView.topAnchor.constraint(equalTo: formsOfPropertyView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: projectAreaView)
        projectAreaView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupApartmentView(){
        apartmentInfomationView.topAnchor.constraint(equalTo: projectAreaView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: apartmentInfomationView)
        apartmentInfomationView.heightAnchor.constraint(equalToConstant: 85).isActive = true
    }
    func setupTotalView(){
        totalApartmentView.topAnchor.constraint(equalTo: apartmentInfomationView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: totalApartmentView)
        totalApartmentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupConvenientServicesView(){
        
        let text = "Swimming pool\nMulti-purpose hall\nGym\nOutdoor Family Corner\nPicnicLawn\nFood reflexology track\nChildren Playground\nBBQ Cabana"
        let size = CGSize(width: view.frame.width - margin - margin, height: 1000)
        let height = String.heightWith(string: text, size: size, font: convenientServicesView.textViewContent.font!)
        
        convenientServicesView.topAnchor.constraint(equalTo: totalApartmentView.bottomAnchor, constant: 1).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: convenientServicesView)
        convenientServicesView.heightAnchor.constraint(equalToConstant: 40 + height).isActive = true
        convenientServicesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    //MARK: - Handle button
    
    func handleCallButton(_ sender : UIButton) {
        if let url = URL(string: "tel://\(home.phone)") {
            UIApplication.shared.open(url, options: [:])
        }
        print("Call")
    }
    
    func handleEmailButton(_ sender : UIButton) {
        let mailComposeVC = configuredMailComposeVC()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            
        }
        print("Email")
    }
    
    func handleGeneralLayoutButton(_ sender: UIButton){
        print("General Layout")
    }
    
    func configuredMailComposeVC() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([home.email])
        mailComposerVC.setSubject(home.title)
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    //MARK: - collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return home.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.detailImage.loadImageUsingUrlString(urlString: home.images[indexPath.item])
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageLauncher.images = home.images
        imageLauncher.show(index: indexPath)
    }
}
