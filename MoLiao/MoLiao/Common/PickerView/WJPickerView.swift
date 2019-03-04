//
//  WJPickerView.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/2/4.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
enum PickerViewType {
    case PickerViewTypeSex  // 性别
    case PickerViewTypeHeigh     // 身高
    case PickerViewTypeWeight  // 体重
    case PickerViewTypeBirthday  // 出生年月
    case PickerViewTypeTime // 十分秒
    case PickerViewTypeRange // 区间
    case PickerViewTypeCity // 城市
}
/// PickerDelegate
protocol PickerViewResultDelegate {
    func pickerView(pickerview:UIView,result:String)
}

class WJPickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var delegate: PickerViewResultDelegate?
    var picker:UIPickerView!
    var datePicke:UIDatePicker!
    var type = PickerViewType.PickerViewTypeCity
    var array = NSMutableArray()
    var selectComponent:NSInteger!
    var bgView:UIView = UIView()
    var cancelBtn:UIButton = UIButton()
    var completeBtn:UIButton = UIButton()
    var titleLab:UILabel = UILabel()
    var line:UIView = UIView()
    var selectIndex:NSInteger!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        self.initUI()
    }
    func initUI() {
        self.backgroundColor = UIColor.black.alpha(0.3)
        self.frame = UIScreen.main.bounds
        bgView = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height, width: kScreenWidth, height: 280))
        self.addSubview(bgView)
        bgView.tag = 100
        bgView.backgroundColor = UIColor.white
        
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        
        datePicke = UIDatePicker.init()
        array = NSMutableArray.init()
        self.showAnimation()
        cancelBtn = UIButton.init(type: .custom)
        bgView.addSubview(cancelBtn)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.frame = CGRect(x: 0, y: 10, width: 40, height: 44)
        cancelBtn.addTarget(self, action: #selector(cancleBtnClick), for: .touchUpInside)
        cancelBtn.setTitleColor(UIColor.orange, for: .normal)
       
        completeBtn = UIButton.init(type: .custom)
        bgView.addSubview(completeBtn)
        completeBtn.frame = CGRect(x: 0, y: 100, width: 40, height: 44)
        completeBtn.setTitle("确定", for: .normal)
        completeBtn.addTarget(self, action: #selector(completeBtnClick), for: .touchUpInside)
        completeBtn.setTitleColor(UIColor.orange, for: .normal)
        
        switch self.type {
        case .PickerViewTypeSex:
            titleLab.text = "选择性别"
            self.sexData()
            self.isDataPicker(isData: false)
            break
        case .PickerViewTypeHeigh:
            titleLab.text = "选择身高"
            self.heigthData()
            self.isDataPicker(isData: false)
            picker.selectRow(70, inComponent: 0, animated: false)
            break
        case .PickerViewTypeWeight:
            titleLab.text = "选择体重"
            self.weightData()
            self.isDataPicker(isData: false)
            picker.selectRow(20, inComponent: 0, animated: false)
            break
        case .PickerViewTypeBirthday:
            titleLab.text = "选择出生年月"
            self.isDataPicker(isData: true)
            datePicke.datePickerMode = UIDatePicker.Mode.date
            break
        case .PickerViewTypeTime:
            titleLab.text = "选择时间"
            self.isDataPicker(isData: true)
            datePicke.datePickerMode = UIDatePicker.Mode.dateAndTime
            break
        case .PickerViewTypeRange:
            titleLab.text = "选择区间"
            self.formatterRangeAry()
            self.isDataPicker(isData: false)
            break
        case .PickerViewTypeCity:
            titleLab.text = "选择城市"
            self.formatterCity()
            self.isDataPicker(isData: false)
            break
        default:
            break
        }
        
        picker.selectRow(selectComponent, inComponent: 0, animated: false)
        
    }
    func formatterCity() {
        let path = Bundle.main.path(forResource: "City.plist", ofType: nil)
        let plistAray = NSArray.init(contentsOfFile: path!)
        for i in 0...plistAray!.count {
            let model = PickerModel.init()
            let dict:NSDictionary = plistAray![i] as! NSDictionary
            model.province = dict.allKeys[0] as? String
            model.cities = dict.object(forKey: model.province) as? NSArray
            self.array.add(model)
        }
    }
    
    func formatterRangeAry() {
        let rang:NSMutableArray = self.array.mutableCopy() as! NSMutableArray
        self.array.removeAllObjects()
        for i in 0..<rang.count - 1{
            let model = PickerModel.init()
            model.province = rang[i] as? String
            let cityAry = NSMutableArray.init()
            for m in i + 1 ..< rang.count {
                cityAry.add(rang[m])
            }
            model.cities = cityAry
            self.array.add(model)
        }
    }
    func weightData() {
        let arr = NSMutableArray.init()
        for i in 30..<150 {
            let str:String = String(i)
            arr.add(str)
        }
        self.array.add(arr)
    }
    
    func heigthData() {
        
    }
    func isDataPicker(isData:Bool) {
        if isData {
            bgView.addSubview(self.datePicke)
            self.datePicke.frame = CGRect(x: 0, y: kScreenHeight - 100, width: kScreenWidth, height: 100)
        }else {
            bgView.addSubview(self.picker)
            self.picker.frame = CGRect(x: 0, y: kScreenHeight - 100, width: kScreenWidth, height: 100)
        }
    }
    func sexData() {
        self.array.add(["男","女"])
    }
    
    @objc func completeBtnClick() {
        self.hideAnimation()
        var resultStr = String.init()
        if self.type == .PickerViewTypeBirthday {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy-MM-dd"
            resultStr = formatter.string(from: self.datePicke.date)
        }else if self.type == .PickerViewTypeTime {
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            resultStr = formatter.string(from: self.datePicke.date)
        }else if self.type == .PickerViewTypeRange || self.type == .PickerViewTypeCity {
            let model:PickerModel = self.array[self.selectIndex] as! PickerModel
            let cityIndex = self.picker.selectedRow(inComponent: 1)
            let cityName:String = model.cities![cityIndex] as! String
            resultStr = model.province + cityName
        }else {
            for i in 0..<self.array.count {
                let arr:NSArray = self.array.object(at: i) as! NSArray
                let str:String = arr.object(at: self.picker.selectedRow(inComponent: i)) as! String
                resultStr = resultStr.appending(str)
            }
        }
    }
    
    
    @objc func cancleBtnClick() {
        self.hideAnimation()
    }
    
    func hideAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.bgView.frame
            frame.origin.y = self.frame.size.height
            self.bgView.frame = frame
            self.alpha = 0
        }) { (finished) in
            self.bgView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.5) {
            var frame = self.bgView.frame
            frame.origin.y = self.frame.size.height - 260
            self.bgView.frame = frame
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if self.type == .PickerViewTypeRange || self.type == .PickerViewTypeCity {
            return 2
        }
        return self.array.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.type == .PickerViewTypeRange || self.type == .PickerViewTypeCity {
            if component == 0 {
                return self.array.count
            }else {
                let model:PickerModel = self.array[self.selectIndex] as! PickerModel
                return model.cities.count
            }
        }
        let arr:NSArray = self.array.object(at: component) as! NSArray
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.type == .PickerViewTypeRange || self.type == .PickerViewTypeCity {
            if component == 0 {
                let model:PickerModel = self.array[row] as! PickerModel
                return model.province
            }else {
                let model:PickerModel = self.array[self.selectIndex] as! PickerModel
                return model.cities?[row] as? String
            }
        }
        let arr:NSArray = self.array.object(at: component) as! NSArray
        return arr.object(at: row % arr.count) as! String
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if self.type == .PickerViewTypeRange || self.type == .PickerViewTypeCity {
                self.selectIndex == pickerView.selectedRow(inComponent: 0)
                pickerView.reloadComponent(1)
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 110
    }

    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
