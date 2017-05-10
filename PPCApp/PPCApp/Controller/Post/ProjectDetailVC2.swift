//
//  ProjectDetailVC2.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/24/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ProjectDetailVC2: BaseVC{
    var post = HomeDataModel()
    let margin : CGFloat = 20.0
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
    
    let titleTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Title"
        return view
    }()
    
    let investorTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Investor"
        return view
    }()
    
    let areaProjectTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "The area of project"
        return view
    }()
    
    let areaAppartmentsTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "The area of apartments"
        return view
    }()
    
    let apartmentsTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Quality of apartments"
        return view
    }()
    
    let floorsTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Quality of floors"
        return view
    }()
    
    let bedroomsTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Quality of bedrooms"
        return view
    }()
    
    let bathroomsTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Quality of bathrooms"
        return view
    }()
    
    
    let servicesTextField: InfoTextField = {
        let view = InfoTextField()
        view.textAlignment = NSTextAlignment.left
        view.placeholder = "Conveninents of services"
        return view
    }()
    
    let buttonNext : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextButton(_:)), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.navigationBar()
        
        return button
    }()
    func inputPostProjectVC2(){
        post.title = titleTextField.text!
        post.investor = investorTextField.text!
        post.acreage = Int(areaProjectTextField.text!)!
        post.area_apartment = Float(areaProjectTextField.text!)!
        post.floor = Int(floorsTextField.text!)!
        post.bedroom = Int(bedroomsTextField.text!)!
        post.bathroom = Int(bathroomsTextField.text!)!
        post.service = servicesTextField.text!
    }

    func handleNextButton(_ sender: UIButton){
        self.inputPostProjectVC2()
        if (checkInputProjectVC2()){
            let proDetailVC3 = ProjectDetailVC3()
            proDetailVC3.post = self.post
            push(viewController: proDetailVC3)
        }else{
            let proDetailVC3 = ProjectDetailVC3()
            push(viewController: proDetailVC3)
        }
        //present(viewController: proDetailVC2)
    }
    
    func checkInputProjectVC2() -> Bool{
        if (titleTextField.text?.isEmpty)! || (investorTextField.text?.isEmpty)! || (areaProjectTextField.text?.isEmpty)! || (areaAppartmentsTextField.text?.isEmpty)! || (apartmentsTextField.text?.isEmpty)! || (floorsTextField.text?.isEmpty)! || (bedroomsTextField.text?.isEmpty)! || (bathroomsTextField.text?.isEmpty)! || (servicesTextField.text?.isEmpty)!{
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Project"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

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
    }
    
    override func setupView() {
        super.setupView()
        setupMainScrollView()
        setupcontentView()
        setupViewComponents()
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
    
    func setupViewComponents(){
        contentView.addSubview(titleTextField)
        contentView.addSubview(investorTextField)
        contentView.addSubview(areaProjectTextField)
        contentView.addSubview(areaAppartmentsTextField)
        contentView.addSubview(apartmentsTextField)
        contentView.addSubview(floorsTextField)
        contentView.addSubview(bedroomsTextField)
        contentView.addSubview(bathroomsTextField)
        contentView.addSubview(servicesTextField)
        contentView.addSubview(buttonNext)
        
        setupTitleView()
        setupInvestorView()
        setupAreaProjectView()
        setupAreaAppartmentsView()
        setupApartmentsView()
        setupFloorsView()
        setupBedRoomsView()
        setupBathRoomsView()
        setupServicesView()
        setupButtonNextView()
    }
    
    func setupTitleView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: titleTextField)
        titleTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupInvestorView() {
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: investorTextField)
        investorTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 2).isActive = true
        investorTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAreaProjectView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: areaProjectTextField)
        areaProjectTextField.topAnchor.constraint(equalTo: investorTextField.bottomAnchor, constant: 2).isActive = true
        areaProjectTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAreaAppartmentsView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: areaAppartmentsTextField)
        areaAppartmentsTextField.topAnchor.constraint(equalTo: areaProjectTextField.bottomAnchor, constant: 2).isActive = true
        areaAppartmentsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupApartmentsView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: apartmentsTextField)
        apartmentsTextField.topAnchor.constraint(equalTo: areaAppartmentsTextField.bottomAnchor, constant: 2).isActive = true
        apartmentsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupFloorsView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: floorsTextField)
        floorsTextField.topAnchor.constraint(equalTo: apartmentsTextField.bottomAnchor, constant: 2).isActive = true
        floorsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupBedRoomsView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: bedroomsTextField)
        bedroomsTextField.topAnchor.constraint(equalTo: floorsTextField.bottomAnchor, constant: 2).isActive = true
        bedroomsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupBathRoomsView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: bathroomsTextField)
        bathroomsTextField.topAnchor.constraint(equalTo: bedroomsTextField.bottomAnchor, constant: 2).isActive = true
        bathroomsTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupServicesView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: servicesTextField)
        servicesTextField.topAnchor.constraint(equalTo: bathroomsTextField.bottomAnchor, constant: 2).isActive = true
        servicesTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupButtonNextView() {
        buttonNext.topAnchor.constraint(equalTo: servicesTextField.bottomAnchor, constant: 20).isActive = true
        buttonNext.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonNext)
        buttonNext.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonNext.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonNext.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
