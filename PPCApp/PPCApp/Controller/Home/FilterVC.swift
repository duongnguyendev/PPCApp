//
//  FilterVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class FilterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filter"
    }

    override func setupView() {
        super.setupView()
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        addFilterButton()
    }
    
    //MARK: - setup nav
    func addFilterButton(){
        let filterButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(handleFilter))
        filterButton.customTitle()
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    func handleFilter(){
        print("show filter input")
    }

}
