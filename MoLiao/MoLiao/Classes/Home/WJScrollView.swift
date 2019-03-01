//
//  WJScrollView.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/28.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class WJScrollView: UIScrollView ,UIGestureRecognizerDelegate{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (otherGestureRecognizer.view?.isKind(of: NSClassFromString("UILayoutContainerView")!))! {
            if otherGestureRecognizer.state == .began && self.contentOffset.x == 0 {
                return true
            }
        }
        return true
    }
}
