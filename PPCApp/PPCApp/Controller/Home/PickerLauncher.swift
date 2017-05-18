//
//  LauncherCountry.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
@objc protocol PickerViewDelegate {
    @objc optional func selectedProjectType(place : Place)
    @objc optional func selectedCountry(place : Place)
    @objc optional func selectedProvince(place : Place)
    @objc optional func selectedDistrict(place : Place)
}
class PickerLauncher: BaseLauncher, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewDelegate?
    override init() {
        super.init()
    }
    let buttonClose : UIButton = {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(name: .close, textColor: UIColor.black, size: CGSize(width: 25, height: 25)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var picker : UIPickerView = {
        let picker = UIPickerView()
        
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    override func setupContent() {
        buttonClose.addTarget(self, action: #selector(handleCloseButton(_:)), for: .touchUpInside)
        
        self.height = windowFrame.size.height / 3
        super.setupContent()
        contentView.addSubview(picker)
        
        contentView.frame = CGRect(x: 0, y: windowFrame.height, width: windowFrame.width, height: height)
        
        contentView.addSubview(buttonClose)
        
        buttonClose.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        buttonClose.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        buttonClose.widthAnchor.constraint(equalToConstant: 25).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buttonClose.layer.zPosition = 1
        
        contentView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: picker)
        contentView.addConstraintWithFormat(format: "V:|[v0]|", views: picker)
    }
    
    override func show() {
        super.show()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.contentView.frame = CGRect(x: 0, y: self.windowFrame.height - self.height, width: self.windowFrame.width, height: self.height)
        }, completion: nil)
    }
    
    override func close() {
        super.close()
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.frame = CGRect(x: 0, y: self.windowFrame.height, width: self.windowFrame.width, height: self.height)
        }) { (Bool) in
            
        }
    }
    
    func handleCloseButton(_ sender : UIButton){
        self.close()
    }
    
    func fretchItem(){
        
    }
    
    //MARK: - pickerView Delegate
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.close()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
}
//MARK: - Type of project Launcher
class TypeOfProjectLauncher: PickerLauncher {
    var projects: [Place]?
    override init() {
        super.init()
        fretchItem()
    }
    override func fretchItem() {
        HomeService.shared.fetchPlaces(pageUrl: "project") { (places, errMess) in
            self.projects = places
            self.picker.reloadAllComponents()
        }
    }
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.projects == nil {
            return 0
        }
        return self.projects!.count
    }
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects?[row].name
    }
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let project = projects?[row]
        if delegate != nil{
            delegate?.selectedProjectType!(place: project!)
        }
        self.close()
    }
    
}
//MARK: - Country Launcher
class CountryLauncher: PickerLauncher {
    var countries : [Place]?
    
    override init() {
        super.init()
        fretchItem()
    }
    override func fretchItem() {
        HomeService.shared.fetchPlaces(pageUrl: "country") { (places, errMess) in
            self.countries = places
            self.picker.reloadAllComponents()
        }
    }
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.countries == nil {
            return 0
        }
        return self.countries!.count
    }
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries?[row].name
    }
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let country = countries?[row]
        if delegate != nil{
            delegate?.selectedCountry!(place: country!)
        }
        self.close()
    }
}
//MARK: - ProvinceLauncher
class ProvinceLauncher: PickerLauncher {
    
    var provinces: [Place]? {
        didSet{
            self.picker.reloadAllComponents()
        }
    }

    override func fretchItem() {
         self.picker.reloadAllComponents()
    }
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.provinces == nil {
            return 0
        }
        return self.provinces!.count
    }
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return provinces?[row].name
    }
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let dictrict = provinces?[row]
        if delegate != nil{
            delegate?.selectedProvince!(place: dictrict!)
        }
        self.close()
    }
}

//MARK: - District Launcher
class DistrictLauncher: PickerLauncher {
    var dictricts: [Place]?{
        didSet{
            self.picker.reloadAllComponents()
        }
    }
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.dictricts == nil {
            return 0
        }
        return self.dictricts!.count
    }
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dictricts?[row].name
    }
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let district = dictricts?[row]
        if delegate != nil{
            delegate?.selectedDistrict!(place: district!)
        }
        self.close()
    }
}
