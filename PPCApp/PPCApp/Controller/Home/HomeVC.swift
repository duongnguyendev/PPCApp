//
//  HomeVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Photos
class HomeVC: BaseVC, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PostVCDelegate {
    var typeSegmentControl: NSNumber = 0
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "home")
        //        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        //        PHImageManager.default().requestImage(for: assets[0], targetSize: CGSize(width: 1000, height: 1000), contentMode: .default, options: nil, resultHandler: { (image, nil) in
        //            self.view.backgroundColor = UIColor.init(patternImage: image!)
        //        })
        segmentedPostType.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        homeCollectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
    }
    let segmentedPostType : UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "Sale", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Rent", at: 1, animated: true)
        segmented.tintColor = UIColor.white
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    let cellId = "cellId"
    lazy var homeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    override func setupNavBar() {
        super.setupNavBar()
        addFilterButton()
        addSearchButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.homeCollectionView.reloadData()
    }
    override func setupView() {
        segmentedPostType.heightAnchor.constraint(equalToConstant: 25).isActive = true
        segmentedPostType.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.navigationItem.titleView = self.segmentedPostType
        
        self.view.addSubview(homeCollectionView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: homeCollectionView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: homeCollectionView)
    }
    //MARK: - segment
    func segmentedValueChanged(_ sender : UISegmentedControl){
        self.typeSegmentControl = NSNumber(value: sender.selectedSegmentIndex)
        let index = IndexPath(item: sender.selectedSegmentIndex, section: 0)
        self.homeCollectionView.scrollToItem(at: index, at: .left, animated: true)
    }
    //Mark: - nav button handle
    
    func handleFilter(){
        let filterVC = FilterVC()
        filterVC.delegate = self
        filterVC.typeSegementControl = self.typeSegmentControl
        self.present(viewController: filterVC)
    }
    func handleSearch() {
        let searchVC = SearchVC()
        self.present(viewController: searchVC)
    }
    // collection delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.indexPage = 1
        cell.delegate = self
        cell.type = indexPath.item
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        segmentedPostType.selectedSegmentIndex = Int(index)
        self.typeSegmentControl = NSNumber(value: segmentedPostType.selectedSegmentIndex)
        self.indexPath = IndexPath(item: Int(index), section: 0)
    }
    //MARK: - setup nav
    func addFilterButton(){
        let filterButton = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .sliders, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .done, target: self, action: #selector(handleFilter))
        filterButton.customTitle()
        filterButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = filterButton
    }
    func addSearchButton(){
        let searchButton = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .search, textColor: UIColor.white, size: CGSize(width: 30, height: 30)), style: .done, target: self, action: #selector(handleSearch))
        searchButton.customTitle()
        searchButton.tintColor = UIColor.white
        searchButton.imageInsets.left = -10
        
        self.navigationItem.leftBarButtonItem = searchButton
    }
    //MARK: - Post detail delegate
    func seleted(home: HomeDataModel) {
        let detailVC = PostDetailVC()
        detailVC.home = home
        self.present(viewController: detailVC)
    }
}
extension HomeVC: HomeVCDelegate{
    func Filter(projects: [HomeDataModel], currentPage: Int, next_page_url: String) {
        let cell = homeCollectionView.cellForItem(at: indexPath) as! HomeCell
        cell.indexPage = currentPage
        cell.nextPage = next_page_url
        cell.homes = projects
        
        cell.collectionViewPost.reloadData()
    }
}
