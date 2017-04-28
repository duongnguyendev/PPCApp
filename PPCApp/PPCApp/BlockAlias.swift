//
//  BlockAlias.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
//PhongDinh
typealias NewsCallback = (_ news: [NewDataModel],_ errMess: Int,_ currentPage: Int,_ next_page_url: String) -> Void
typealias HomeCallback = (_ homes: [HomeDataModel],_ errMess: Int,_ currentPage: Int,_ next_page_url: String) -> Void
typealias PlaceCallback = (_ places: [Place],_ errMess: Int) -> Void
typealias SearchCallback = (_ searchs: [HomeDataModel],_ errMess: Int,_ currentPage: Int,_ next_page_url: String) -> Void
typealias ProjectManagerCallBack = (_ projects: [HomeDataModel],_ errMess: Int) -> Void
typealias PhotoCallBack = (_ images: [UIImage])-> Void
