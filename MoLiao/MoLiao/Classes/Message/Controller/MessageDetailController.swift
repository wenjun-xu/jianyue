//
//  MessageDetailController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/17.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
class MessageDetailController: MyLikeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 80, height: 30)
        btn.setTitle("下一页", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = UIColor.orange
        btn.setImage(UIImage(named: "guanzhu"), for: .normal)
        btn.addTarget(self, action: #selector(btnclick), for: .touchUpInside)
        view.addSubview(btn)
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 50, bottom: 0, right: 0)
    }
   
    @objc func btnclick() {
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
