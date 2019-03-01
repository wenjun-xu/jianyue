//
//  WJDynamicNewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/29.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class WJDynamicNewController: BaseViewController,HXPhotoViewDelegate,UITextViewDelegate {
    var bottomView:UIButton!
    var manager:HXPhotoManager!
    var scrollView:UIScrollView!
    var photoView:HXPhotoView!
    var needDeleteItem:Bool!
    var leftBarItemtwo:UIBarButtonItem!
    var textView:UITextView!
    var textLabel:UILabel!
    var textStr:String!
    var lastTextViewHeight:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        leftBarItemtwo = UIBarButtonItem.init(title: "发表", style: .plain, target: self, action: #selector(self.uploadImages))
        self.navigationItem.rightBarButtonItem = leftBarItemtwo

        //
//        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(rightClick))
//        self.navigationItem.leftBarButtonItem = backItem
//        creatNavigationBarColor(barTintColor: kBgColor, tintColor: UIColor(red: 93/255.0, green: 143/255.0, blue: 80/255.0, alpha: 1), barTitleColor: UIColor.green)

        createUpdateView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面

    }
    
    func createUpdateView() {
        bottomView = UIButton.init(type: .custom)
        bottomView.setTitle("删除", for: .normal)
        bottomView.setTitleColor(UIColor.white, for: .normal)
        bottomView.backgroundColor = UIColor.red
        bottomView.frame = CGRect(x: 0, y: kScreenHeight - 50 - kNavH - kStatusBarH, width: kScreenWidth, height: 50)
        bottomView.alpha = 0
        
        manager = HXPhotoManager.init(type: .photo)
        manager?.configuration.openCamera = false
        manager?.configuration.lookLivePhoto = true
        manager?.configuration.photoMaxNum = 9
        manager?.configuration.videoMaxNum = 1
        manager?.configuration.videoMaxDuration = 500
        manager?.configuration.saveSystemAblum = true
        manager?.configuration.showDateSectionHeader = false
        manager?.configuration.selectTogether = false
        manager?.configuration.requestImageAfterFinishingSelection = true
        manager?.configuration.albumShowMode = .popup
        
        scrollView = UIScrollView.init(frame: self.view.bounds)
//        scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavH - kStatusBarH))
//        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        textView = UITextView.init(frame: CGRect(x: 20, y: 10, width: kScreenWidth - 40, height: 80))
        textView.font = UIFont.systemFont(ofSize:16.0)
        textView.tintColor = UIColor.red
        textView.backgroundColor = UIColor.white
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: -5)
        textLabel = UILabel.init(frame: CGRect(x: 7, y: 3, width: 200, height: 30))
        textLabel.textAlignment = .left
        textLabel.text = "把想说的记录下来..."
        textLabel.font = UIFont.systemFont(ofSize: 16.0)
        textLabel.textColor = UIColor(red: 176/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1)
        textView.addSubview(textLabel)
        scrollView.addSubview(textView)
        
        photoView = HXPhotoView.photoManager(manager)
        photoView.frame = CGRect(x: 20, y: 110, width: kScreenWidth - 40, height: 0)
        photoView.delegate = self
        photoView.previewStyle = .dark
        photoView.previewShowDeleteButton = false
        photoView.showAddCell = true
        photoView.collectionView.reloadData()
        scrollView.addSubview(photoView)
        view.addSubview(bottomView)
    }
    
    @objc func uploadImages() {
        leftBarItemtwo.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.7) {
            self.leftBarItemtwo.isEnabled = true
            self.navigationController?.popViewController(animated: true)
        }
        let count = textView.text.count
        if count == 0 {
            return
        }
        textView.resignFirstResponder()        
    }
    @objc func rightClick() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text.length == 0 {
            textLabel.text = "把想说的记录下来..."
        }else {
            textLabel.text = ""
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.length == 0 {
            textLabel.text = "把想说的记录下来..."
        }else {
            textLabel.text = ""
        }
        let size = textView.sizeThatFits(CGSize(width: kScreenWidth - 40, height: 800))
        var height = size.height
        var scrollEnabled = false
        if height > 25 * 5 {
            height = 25 * 5
            scrollEnabled = true
        }else if height < 80 {
            height = 80
        }
        textView.isScrollEnabled = scrollEnabled
        textView.height = height
        updateHeaderViewHeight()
        lastTextViewHeight = height
    }
    
    func updateHeaderViewHeight(){
        photoView.y = textView.height + 10 + 20
    }
    
    func photoViewChangeComplete(_ photoView: HXPhotoView!, allAssetList: [PHAsset]!, photoAssets: [PHAsset]!, videoAssets: [PHAsset]!, original isOriginal: Bool) {
        
    }
    func photoView(_ photoView: HXPhotoView!, imageChangeComplete imageList: [UIImage]!) {
        print("imageList",imageList)
    }
    
    func photoView(_ photoView: HXPhotoView!, deleteNetworkPhoto networkPhotoUrl: String!) {
        print("networkPhotoUrl",networkPhotoUrl)
    }
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: (frame).maxY + 12)
    }
    func photoView(_ photoView: HXPhotoView!, currentDelete model: HXPhotoModel!, currentIndex index: Int) {
        print("index==",index)
    }
    func photoViewShouldDeleteCurrentMoveItem(_ photoView: HXPhotoView!, gestureRecognizer longPgr: UILongPressGestureRecognizer!, indexPath: IndexPath!) -> Bool {
        return needDeleteItem
    }
    
    func photoView(_ photoView: HXPhotoView!, gestureRecognizerBegan longPgr: UILongPressGestureRecognizer!, indexPath: IndexPath!) {
        UIView.animate(withDuration: 0.25) {
            self.bottomView.alpha = 0.5
        }
    }
    
    func photoView(_ photoView: HXPhotoView!, gestureRecognizerChange longPgr: UILongPressGestureRecognizer!, indexPath: IndexPath!) {
        let potin = longPgr.location(in: self.view)
        if potin.y >= bottomView.y - kNavH - kStatusBarH {
            UIView.animate(withDuration: 0.25) {
                self.bottomView.alpha = 1
            }
        }else {
            UIView.animate(withDuration: 0.25) {
                self.bottomView.alpha = 0.5
            }

        }
        
    }
    
    func photoView(_ photoView: HXPhotoView!, gestureRecognizerEnded longPgr: UILongPressGestureRecognizer!, indexPath: IndexPath!) {
        let potin = longPgr.location(in: self.view)
        if potin.y >= bottomView.y - kNavH - kStatusBarH {
            needDeleteItem = true
            photoView.deleteModel(with: indexPath.item)
        }else {
            needDeleteItem = false
        }
        UIView.animate(withDuration: 0.25) {
            self.bottomView.alpha = 0
        }
    }
   

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



















