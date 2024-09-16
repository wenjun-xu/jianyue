//
//  MonologueViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/15.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class MonologueViewController: BaseViewController {
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "内心独白"
        let leftSpace:CGFloat = 10
        textView = UITextView.init(frame: CGRect(x: leftSpace, y: leftSpace, width: kScreenWidth - 2*leftSpace, height: 200))
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
        textView.tintColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 15.0)
        view.addSubview(textView)

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(self.uploadImages))

    }
    

    @objc func uploadImages() {
      
        
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
