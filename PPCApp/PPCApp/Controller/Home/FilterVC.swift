//
//  FilterVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FilterVC: BaseVC {
    
    let spaceLine : CGFloat = 2.0
    let itemSize : CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filter"
    }
    
    let countryButton : FilterButton = {
        let button = FilterButton()
        button.title = "Country"
        button.value = "All"
        button.addTarget(self, action: #selector(handleContryButton(_:)), for: .touchUpInside)
        return button
    }()
    let provinceButton : FilterButton = {
        let button = FilterButton()
        button.addTarget(self, action: #selector(handleProvinceButton(_:)), for: .touchUpInside)
        button.title = "Province"
        button.value = "All"
        return button
    }()
    
    let districtButton : FilterButton = {
        let button = FilterButton()
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
        view.addSubview(countryButton)
        view.addSubview(provinceButton)
        view.addSubview(districtButton)
        view.addSubview(typeOfProjectButton)
        
        view.addConstraintWithFormat(format: "V:|[v0(\(itemSize))]-\(spaceLine)-[v1(\(itemSize))]-\(spaceLine)-[v2(\(itemSize))]-\(spaceLine)-[v3(\(itemSize))]", views: countryButton, provinceButton, districtButton, typeOfProjectButton)
        
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
    
    func handleContryButton(_ sender: UIButton){
//        print("handleContryButton")
        self.countryLaucher.show()
    }
    func handleProvinceButton(_ sender: UIButton){
        self.provinceLauncher.show()
    }
    func handleDistrictButton(_ sender: UIButton){
        self.districtLauncher.show()
    }
    func handleTypeOfProjectButton(_ sender: UIButton){
        self.typeOfProjectLauncher.show()
    }
    
    //MARK: - setup nav
    func addFilterButton(){
        let filterButton = UIBarButtonItem(title: "Complete", style: .done, target: self, action: #selector(handleComplete(_:)))
        filterButton.customTitle()
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    func handleComplete(_ sender : UIBarButtonItem){
        print("Complete")
    }
    
}
