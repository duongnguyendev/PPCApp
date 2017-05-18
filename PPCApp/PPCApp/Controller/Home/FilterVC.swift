//
//  FilterVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
@objc protocol HomeVCDelegate {
    //@objc optional func seleted(index : IndexPath)
    @objc optional func Filter(projects : [HomeDataModel],currentPage: Int,next_page_url: String)
}
class FilterVC: BaseVC {
    let spaceLine : CGFloat = 2.0
    let itemSize : CGFloat = 40.0
    var id_projectType: NSNumber = 0
    var id_country: NSNumber = 0
    var id_province: NSNumber = 0
    var id_district: NSNumber = 0
    
    var typeSegementControl: NSNumber = 0
    
    var delegate: HomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
    }
    override func viewWillAppear(_ animated: Bool) {
        provinceButton.isEnabled = false
        districtButton.isEnabled = false
    }
    let countryButton : FilterButton = {
        let button = FilterButton()
        button.title = "Country"
        button.value = "All"
        button.addTarget(self, action: #selector(handleCountryButton(_:)), for: .touchUpInside)
        return button
    }()
    let provinceButton : FilterButton = {
        let button = FilterButton()
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleProvinceButton(_:)), for: .touchUpInside)
        button.title = "Province"
        button.value = "All"
        return button
    }()
    
    let districtButton : FilterButton = {
        let button = FilterButton()
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleDistrictButton(_:)), for: .touchUpInside)
        button.title = "District"
        button.value = "All"
        return button
    }()
    
    let typeOfProjectButton : FilterButton = {
        let button = FilterButton()
        button.addTarget(self, action: #selector(handleTypeOfProjectButton(_:)), for: .touchUpInside)
        button.title = "Type of Projects"
        button.value = "All"
        return button
    }()
    
    let countryLaucher = CountryLauncher()
    let provinceLauncher = ProvinceLauncher()
    let districtLauncher = DistrictLauncher()
    let typeOfProjectLauncher = TypeOfProjectLauncher()
    
    override func setupView() {
        super.setupView()
        view.addSubview(typeOfProjectButton)
        view.addSubview(countryButton)
        view.addSubview(provinceButton)
        view.addSubview(districtButton)
        
        view.addConstraintWithFormat(format: "V:|[v0(\(itemSize))]-\(spaceLine)-[v1(\(itemSize))]-\(spaceLine)-[v2(\(itemSize))]-\(spaceLine)-[v3(\(itemSize))]", views: countryButton, provinceButton, districtButton,typeOfProjectButton)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: countryButton)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: provinceButton)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: districtButton)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: typeOfProjectButton)
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        addFilterButton()
    }
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
    //MARK: - setup nav
    func addFilterButton(){
        let filterButton = UIBarButtonItem(title: "Complete", style: .done, target: self, action: #selector(handleComplete(_:)))
        filterButton.customTitle() 
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    func handleComplete(_ sender : UIBarButtonItem){
        HomeService.shared.fetchHomesFilter(id_projectType: id_projectType, id_country: id_country, id_province: id_province, id_district: id_district,type: typeSegementControl) { (homes, errMess, currentPage, next_page_url) in
            if errMess == 1{
                if self.delegate != nil{
                    self.delegate?.Filter!(projects: homes, currentPage: currentPage, next_page_url: next_page_url)
                    self.goBack()
                }
            }
        }
    }
}
extension FilterVC: PickerViewDelegate{
    func selectedProjectType(place: Place) {
        self.id_projectType = place.id
        typeOfProjectButton.value = place.name
    }
    func selectedCountry(place: Place){
        countryButton.value = place.name
        self.id_country = place.id
        HomeService.shared.fetchPlaces(pageUrl: "province?id_country=\(id_country)") { (places, errMess) in
            self.provinceLauncher.provinces = places
            self.id_province = places[0].id
            self.provinceButton.value = places[0].name
            self.provinceButton.isEnabled = true
        }
    }
    func selectedProvince(place: Place) {
        provinceButton.value = place.name
        self.id_province = place.id
        HomeService.shared.fetchPlaces(pageUrl: "district?id_province=\(id_province)") { (places, errMess) in
            if places.count > 0{
                self.districtLauncher.dictricts = places
                self.id_district = places[0].id
                self.districtButton.value = places[0].name
                 self.districtButton.isEnabled = true
            }
        }
    }
    func selectedDistrict(place: Place) {
        self.id_district = place.id
        districtButton.value = place.name
    }
}
