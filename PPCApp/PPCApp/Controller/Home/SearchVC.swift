//
//  SearchVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Speech
class SearchVC: BaseVC, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var searchs = [HomeDataModel]()
    var indexPage: Int = 1
    var nextPage: String = ""
    var textSearch:String? {
        didSet{
            HomeService.shared.fetchHomesSearch(textSearch: textSearch!,indexPgae: indexPage) { (searchs, errMess, currentPage, next_page_url) in
                self.indexPage = currentPage
                self.nextPage = next_page_url
                self.searchs = searchs
                self.collectionSearchResult.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        collectionSearchResult.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        textFieldSearch.addTarget(self, action: #selector(textFielDidChange(_:)), for: .editingChanged)
        super.viewDidLoad()
        title = "Search"
        self.collectionSearchResult.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            switch authStatus {
            case .authorized:
                //isButtonEnabled = true
                break
            case .denied:
                //isButtonEnabled = false
                break
            case .restricted:
                //isButtonEnabled = false
                break
            case .notDetermined:
                //isButtonEnabled = false
                break
            }
        }
    }
    lazy var collectionSearchResult : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    lazy var textFieldSearch : UITextField = {
        let tF = UITextField()
        tF.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        tF.placeholder = "Search"
        tF.returnKeyType = .search
        tF.delegate = self
        return tF
    }()
    let buttonMic : UIButton = {
        let bt = UIButton(type: UIButtonType.custom)
        bt.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        bt.setTitle(String.fontAwesomeIcon(name: .microphone), for: .normal)
        bt.setTitleColor(UIColor.navigationBar(), for: .normal)
        bt.addTarget(self, action: #selector(handleButtonMic(_:)), for: .touchUpInside)
        return bt
    }()
    override func setupView() {
        super.setupView()
        let labelSearchIcon = UILabel()
        labelSearchIcon.font = UIFont.fontAwesome(ofSize: 20)
        labelSearchIcon.text = String.fontAwesomeIcon(name: .search)
        labelSearchIcon.textAlignment = .center
        labelSearchIcon.textColor = UIColor.lightGray
        
        view.addSubview(labelSearchIcon)
        view.addSubview(textFieldSearch)
        view.addSubview(buttonMic)
        view.addSubview(collectionSearchResult)
        
        view.addConstraintWithFormat(format: "V:|[v0(40)][v1]|", views: textFieldSearch, collectionSearchResult)
        view.addConstraintWithFormat(format: "H:|[v0(40)][v1][v2(40)]|", views: labelSearchIcon, textFieldSearch, buttonMic)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionSearchResult)
        labelSearchIcon.centerYAnchor.constraint(equalTo: textFieldSearch.centerYAnchor, constant: 0).isActive = true
        
        buttonMic.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        buttonMic.centerYAnchor.constraint(equalTo: textFieldSearch.centerYAnchor, constant: 0).isActive = true
    }
    
    let microLauncher = MicroLauncher()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: LanguageManager.shared.getCurrentLanguage().languageCode!))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func handleButtonMic (_ sender : UIButton){
        self.view.endEditing(true)
        microLauncher.show()
        startRecording()
    }
    func startRecording() {
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                self.handleSearch(text: (result?.bestTranscription.formattedString)!)
                self.textFieldSearch.text = result?.bestTranscription.formattedString
                
                self.audioEngine.stop()
                recognitionRequest.endAudio()
                
                isFinal = (result?.isFinal)!
                self.microLauncher.close()
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                //self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func handleSearch(text: String){
        
        self.textSearch = text
        print("Searching with text \(text)")
    }
    
    //MARK: - textFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFielDidChange(_ textField : UITextField){
        handleSearch(text: textField.text!)
    }
    
    //MARK: - CollectionViewDelegate
    let cellId = "cellId"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return searchs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
        cell.home = searchs[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = view.frame.size.width * 9 / 16 + 80
        return CGSize(width: view.frame.size.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetailVC = PostDetailVC()
        postDetailVC.home = searchs[indexPath.item]
        push(viewController: postDetailVC)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.item
        if index == searchs.count - 1{
            if self.nextPage != ""{
                HomeService.shared.fetchHomesSearch(textSearch: textSearch!,indexPgae: indexPage + 1) { (mSearchs, errMess, currentPage, next_page_url) in
                    self.indexPage = currentPage
                    self.nextPage = next_page_url
                    self.searchs = self.searchs + mSearchs
                    self.collectionSearchResult.reloadData()
                }
            }
        }
    }
}
