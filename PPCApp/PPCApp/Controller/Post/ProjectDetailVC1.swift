//
//  PostProjectVC1.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ProjectDetailVC1: BaseVC {
    var post = HomeDataModel()
    let spaceLine : CGFloat = 2.0
    let itemSize : CGFloat = 40.0
    let margin: CGFloat = 20.0
    var id_projectType: NSNumber = 0
    var id_country: NSNumber = 0
    var id_provine: NSNumber = 0
    var id_district: NSNumber = 0
    
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
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Transaction form"
        label.textColor = UIColor.navigationBar()
        return label
    }()
    let radioSaleButton: RadioButtonView = {
        let button = RadioButtonView()
        button.name = "Sale"
        button.isSelected = true
        button.flag = true
        button.addTarget(self, action: #selector(handleRadioSaleButton(_:)), for: .touchUpInside)
        return button
    }()
    let radioRentButton: RadioButtonView = {
        let button = RadioButtonView()
        button.name = "Rent"
        button.isSelected = true
        button.flag = false
        button.addTarget(self, action: #selector(handleRadioRentButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //Handle RadioButton
    func handleRadioSaleButton(_ sender: RadioButtonView){
        if sender.isSelected{
            sender.flag = true
            post.type = 0
            radioRentButton.flag = false
        }
    }
    func handleRadioRentButton(_ sender: RadioButtonView){
        if sender.isSelected{
            sender.flag = true
            post.type = 1
            radioSaleButton.flag = false
        }
    }
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Select language of the post"
        label.textColor = UIColor.navigationBar()
        return label
    }()
    let checkboxVI: CheckBox = {
        let checkbox = CheckBox()
        checkbox.name = "Vietnamese"
        checkbox.addTarget(self, action: #selector(handlecheckboxVI(_:)), for: .touchUpInside)
        checkbox.flag = false
        return checkbox
    }()
    let checkboxEN: CheckBox = {
        let checkbox = CheckBox()
        checkbox.name = "English"
        checkbox.addTarget(self, action: #selector(handlecheckboxEN(_:)), for: .touchUpInside)
        checkbox.flag = false
        return checkbox
    }()
    //Handle CheckBox Language
    func handlecheckboxVI(_ sender: CheckBox){
        if sender.flag!{
            post.langVI = 0
            sender.flag = false
        }else{
            post.langVI = 1
            sender.flag = true
        }
        print("Handle Check VI")
    }
    func handlecheckboxEN(_ sender: CheckBox){
        if sender.flag!{
            post.langEN = 0
            sender.flag = false
        }else{
            post.langEN = 1
            sender.flag = true
        }
        print("Handle Check EN")
    }
    let countryButton : FilterButton = {
        let button = FilterButton()
        button.title = "Country"
        button.value = ""
        button.addTarget(self, action: #selector(handleCountryButton(_:)), for: .touchUpInside)
        return button
    }()
    let provinceButton : FilterButton = {
        let button = FilterButton()
        button.addTarget(self, action: #selector(handleProvinceButton(_:)), for: .touchUpInside)
        button.title = "Province"
        button.value = ""
        return button
    }()
    let districtButton : FilterButton = {
        let button = FilterButton()
        button.addTarget(self, action: #selector(handleDistrictButton(_:)), for: .touchUpInside)
        button.title = "District"
        button.value = ""
        return button
    }()
    let typeOfProjectButton : FilterButton = {
        let button = FilterButton()
        button.addTarget(self, action: #selector(handleTypeOfProjectButton(_:)), for: .touchUpInside)
        button.title = "Type of Projects"
        button.value = ""
        return button
    }()
    
    let countryLaucher = CountryLauncher()
    let provinceLauncher = ProvinceLauncher()
    let districtLauncher = DistrictLauncher()
    let typeOfProjectLauncher = TypeOfProjectLauncher()
    
    //MARK: - Handle button
    func handleCountryButton(_ sender: UIButton){
        self.countryLaucher.delegate = self
        self.countryLaucher.show()
    }
    func handleProvinceButton(_ sender: UIButton){
        self.provinceLauncher.delegate = self
        self.provinceLauncher.show()
    }
    func handleDistrictButton(_ sender: UIButton){
        self.districtLauncher.delegate = self
        self.districtLauncher.show()
    }
    func handleTypeOfProjectButton(_ sender: UIButton){
        self.typeOfProjectLauncher.delegate = self
        self.typeOfProjectLauncher.show()
    }
    
    let emailTextField: InfoTextField = {
        let view = InfoTextField()
        view.placeholder = "Email"
        return view
    }()
    
    let phoneTextField: InfoTextField = {
        let view = InfoTextField()
        view.keyboardType = UIKeyboardType.numberPad
        view.addTarget(self, action: #selector(phoneTextField_textChange(_:)), for: .editingChanged)
        view.placeholder = "Phone"
        return view
    }()
    
    let addressTextField: InfoTextField = {
        let view = InfoTextField()
        view.placeholder = "Address"
        return view
    }()
    
    let ownerTextField: InfoTextField = {
        let view = InfoTextField()
        view.placeholder = "Forms of property ownership"
        return view
    }()
    
    let priceTextField: InfoTextField = {
        let view = InfoTextField()
        view.placeholder = "Price"
        return view
    }()
    
    let projectTextField: InfoTextField = {
        let view = InfoTextField()
        view.placeholder = "Project Infomation"
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
    
    func inputPostProjectVC1(){
        post.country_id = id_country
        post.provine_id = id_provine
        post.district_id = id_district
        post.project_id = id_projectType
        post.email = emailTextField.text!
        post.phone = phoneTextField.text!
        post.address = addressTextField.text!
        post.ownership = ownerTextField.text!
        post.price = priceTextField.text!
        post.info = projectTextField.text!
    }
    func handleNextButton(_ sender: UIButton){
        if checkInputProjectVC1(){
            if validateEmail(email: emailTextField.text!){
                let proDetailVC2 = ProjectDetailVC2()
                proDetailVC2.post = self.post
                push(viewController: proDetailVC2)
            }else{
                self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "incorrectEmail")!)
            }
            
        }else{
            self.showAlertController(title: "", message: LanguageManager.shared.localized(string: "message_inputinfo")!)
        }
    }
    func phoneTextField_textChange(_ sender: Any){
        let lenght = phoneTextField.text?.characters.count
        let metin = phoneTextField.text
        if lenght! > 11{
            let index = metin?.index((metin?.startIndex)!, offsetBy: 11)
            phoneTextField.text = phoneTextField.text?.substring(to: index!)
        }
    }
    func validateEmail(email: String) ->Bool {
        let mobileFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileFormat)
        let mobileTestResult = mobileTest.evaluate(with: email)
        if mobileTestResult {
            return true
        }
        return false
    }
    func checkInputProjectVC1() -> Bool{
        if (countryButton.value?.isEmpty)! || (provinceButton.value?.isEmpty)! || (districtButton.value?.isEmpty)! || (typeOfProjectButton.value?.isEmpty)! || (emailTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (addressTextField.text?.isEmpty)! || (ownerTextField.text?.isEmpty)! || (priceTextField.text?.isEmpty)! || (projectTextField.text?.isEmpty)! ||
            (checkboxEN.flag == false && checkboxVI.flag == false){
            return false
        }
        self.inputPostProjectVC1()
        return true
    }
    
    func showAlertController(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dimiss", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Project"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if post.type == 0{
            radioRentButton.flag = false
            radioSaleButton.flag = true
        }else{
            radioSaleButton.flag = false
            radioRentButton.flag = true
        }
        if post.langEN == 1{
            checkboxEN.flag = true
            checkboxVI.isEnabled = false
        }else if post.langVI == 1{
            checkboxVI.flag = true
            checkboxEN.isEnabled = false
        }
        self.id_country = post.country_id
        self.id_provine = post.provine_id
        self.id_district = post.district_id
        self.id_projectType = post.project_id
        countryButton.value = post.country
        provinceButton.value = post.province
        districtButton.value = post.district
        typeOfProjectButton.value = post.project
        emailTextField.text! = post.email
        phoneTextField.text! = post.phone
        addressTextField.text! = post.address
        ownerTextField.text! = post.ownership
        priceTextField.text! = post.price
        projectTextField.text! = post.info
       
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
        //PickerView
        contentView.addSubview(typeLabel)
        contentView.addSubview(radioSaleButton)
        contentView.addSubview(radioRentButton)
        contentView.addSubview(languageLabel)
        contentView.addSubview(checkboxVI)
        contentView.addSubview(checkboxEN)
        
        contentView.addSubview(countryButton)
        contentView.addSubview(provinceButton)
        contentView.addSubview(districtButton)
        contentView.addSubview(typeOfProjectButton)
        
        contentView.addSubview(emailTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(addressTextField)
        contentView.addSubview(ownerTextField)
        contentView.addSubview(priceTextField)
        contentView.addSubview(projectTextField)
        contentView.addSubview(buttonNext)
        
        setupTypeProjectView()
        setupRadioButtonView()
        setupLanguageView()
        setupCheckBoxView()
        setupPickerView()
        setupEmailView()
        setupPhoneView()
        setupAddressView()
        setupOwnerView()
        setupPriceView()
        setupProjectView()
        setupButtonNextView()
    }
    
    func setupTypeProjectView(){
        contentView.addConstraintWithFormat(format: "H:|-20-[v0]|", views: typeLabel)
        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupLanguageView(){
        contentView.addConstraintWithFormat(format: "H:|-20-[v0]|", views: languageLabel)
        languageLabel.topAnchor.constraint(equalTo: radioSaleButton.bottomAnchor, constant: 2).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupRadioButtonView(){
        contentView.addConstraint(NSLayoutConstraint(item: radioSaleButton, attribute: .width, relatedBy: .equal, toItem: radioRentButton, attribute: .width, multiplier: 1, constant: 0))
        radioSaleButton.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 2).isActive = true
        radioSaleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        radioRentButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        radioRentButton.centerYAnchor.constraint(equalTo: radioSaleButton.centerYAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-|", views: radioSaleButton, radioRentButton)
    }
    
    func setupCheckBoxView(){
        contentView.addConstraint(NSLayoutConstraint(item: checkboxVI, attribute: .width, relatedBy: .equal, toItem: checkboxEN, attribute: .width, multiplier: 1, constant: 0))
        
        checkboxVI.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 2).isActive = true
        checkboxVI.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        checkboxEN.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkboxEN.centerYAnchor.constraint(equalTo: checkboxVI.centerYAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-|", views: checkboxVI, checkboxEN)
    }
    
    func setupPickerView(){
        countryButton.topAnchor.constraint(equalTo: checkboxVI.bottomAnchor, constant: 0).isActive = true
        contentView.addConstraintWithFormat(format: "V:[v0(\(itemSize))]-\(spaceLine)-[v1(\(itemSize))]-\(spaceLine)-[v2(\(itemSize))]-\(spaceLine)-[v3(\(itemSize))]", views: countryButton, provinceButton, districtButton,typeOfProjectButton)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: countryButton)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: provinceButton)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: districtButton)
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: typeOfProjectButton)
    }
    
    func setupEmailView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: emailTextField)
        emailTextField.topAnchor.constraint(equalTo: typeOfProjectButton.bottomAnchor, constant: 2).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPhoneView() {
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAddressView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: addressTextField)
        addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 2).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupOwnerView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: ownerTextField)
        ownerTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 2).isActive = true
        ownerTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPriceView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: priceTextField)
        priceTextField.topAnchor.constraint(equalTo: ownerTextField.bottomAnchor, constant: 2).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupProjectView(){
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: projectTextField)
        projectTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 2).isActive = true
        projectTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func setupButtonNextView(){
        buttonNext.topAnchor.constraint(equalTo: projectTextField.bottomAnchor, constant: 20).isActive = true
        buttonNext.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonNext.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buttonNext.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonNext.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
extension ProjectDetailVC1: PickerViewDelegate{
    func selectedProjectType(place: Place) {
        self.id_projectType = place.id
        typeOfProjectButton.value = place.name
    }
    func selectedCountry(place: Place){
        countryButton.value = place.name
        self.id_country = place.id
        HomeService.shared.fetchPlaces(pageUrl: "province?id_country=\(id_country)") { (places, errMess) in
            self.provinceLauncher.provinces = places
            self.id_provine = places[0].id
            self.provinceButton.value = places[0].name
        }
    }
    func selectedProvince(place: Place) {
        provinceButton.value = place.name
        self.id_provine = place.id
        HomeService.shared.fetchPlaces(pageUrl: "district?id_province=\(id_provine)") { (places, errMess) in
            if places.count > 0{
                self.districtLauncher.dictricts = places
                self.id_district = places[0].id
                self.districtButton.value = places[0].name
            }
        }
    }
    func selectedDistrict(place: Place) {
        self.id_district = place.id
        districtButton.value = place.name
    }
    
}
