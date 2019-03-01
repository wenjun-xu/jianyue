//
//  ViewController.swift
//  JY
//
//  Created by 徐庆标 on 2019/3/1.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "测试"
        let abc = add()
        print(abc)

    }
}

extension ViewController {
    func add() -> Int{
        
        let a = 2
        
        let b = 3
        
        return a + b
    }
}

