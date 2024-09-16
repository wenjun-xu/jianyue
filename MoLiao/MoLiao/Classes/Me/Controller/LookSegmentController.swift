//
//  LookSegmentController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/19.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class LookSegmentController: BaseViewController {
    var segmented: UISegmentedControl!
    var firstController: LookMeController!
    var secondController: MeLookController!
    var isLookMe = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstController = LookMeController()
        firstController.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.addChild(firstController)
        self.view.addSubview(firstController.view)
        
        secondController = MeLookController()
        secondController.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.addChild(secondController)
        self.view.addSubview(secondController.view)
        
        firstController.view.isHidden = false
        secondController.view.isHidden = true
        
        var items = [String]()
        if isLookMe {
            items = ["谁看过我", "我看过谁"]
        }else {
            items = ["关注我的", "我关注的"]
        }
        segmented = UISegmentedControl(items:items)
        segmented.layer.cornerRadius = 4
        segmented.layer.masksToBounds = true
        segmented.backgroundColor = kNavColor
        segmented.tintColor = UIColor.orange
        segmented.center = self.view.center
        
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(self.segmentDidchange(_:)),
                            for: .valueChanged)
        self.navigationItem.titleView = segmented
    }
    @objc func segmentDidchange(_ segmented:UISegmentedControl){
        switch segmented.selectedSegmentIndex
        {
        case 0:
            firstController.view.isHidden = false
            secondController.view.isHidden = true
        case 1:
            firstController.view.isHidden = true
            secondController.view.isHidden = false
        default:
            break;
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
