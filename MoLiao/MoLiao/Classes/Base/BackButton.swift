//
//  BackButton.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/16.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    
    init(target: Any, action: Selector) {
        super.init(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        commonInit(target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(target: Any, action: Selector) {
        
        self.adjustsImageWhenHighlighted = false
        self.setBackgroundImage(UIImage(named: "fanhui"), for: .normal)
        self.setBackgroundImage(UIImage(named: "fanhui"), for: .highlighted)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(self.width > 20 ? self.width - 20 : self.width), bottom: 0, right:0)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
