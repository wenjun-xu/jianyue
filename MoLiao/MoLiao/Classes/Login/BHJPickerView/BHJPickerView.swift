//
//  BHJPickerView.swift
//  BHJPickerView
//
//  Created by 白华君 on 2018/5/21.
//  Copyright © 2018年 baihuajun. All rights reserved.
//

import UIKit

/// PickerDelegate
protocol PickerDelegate {
     
     func selectedAddress(_ pickerView : BHJPickerView,_ procince : AddressModel,_ city : AddressModel,_ area : AddressModel)
    
}


class BHJPickerView: UIView , UIPickerViewDelegate, UIPickerViewDataSource{
     
     
     var pickerDelegate : PickerDelegate?
     private let pickerH : CGFloat! = 260 * kScalHeight
     private var addressPicker : UIPickerView = UIPickerView()
     private var dataArray : NSMutableArray = NSMutableArray()
     private var cityArray : NSMutableArray = NSMutableArray()
     private var districtArray : NSMutableArray = NSMutableArray()
     private var selectedProvince : AddressModel = AddressModel()
     private var selectedCity : AddressModel = AddressModel()
     private var selectedDistrict : AddressModel = AddressModel()
     private var selectedGender : String = String()
   
     // MARK: - 初始化UI
     init(_ delegate : PickerDelegate,frame: CGRect){
          
          dataArray.removeAllObjects()
          pickerDelegate = delegate
          super.init(frame: frame)
       
        addressPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        addressPicker.delegate = self
        addressPicker.dataSource = self
        
        addressPicker.backgroundColor = UIColor.white
        self.addSubview(addressPicker)
        getAddressData()
     }
     required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     
     /// 读取省市区数据
     func getAddressData() {
          
          dataArray.removeAllObjects()
          let path = Bundle.main.path(forResource:"city", ofType: "json")
          let url = URL(fileURLWithPath: path!)
          let addressData = NSData.init(contentsOf: url)
          let addressDic = try! JSONSerialization.jsonObject(with: addressData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
          let dic = addressDic.object(at: 0) as! NSDictionary
          let provinceArray = dic["childs"] as! NSArray
          for i in 0..<provinceArray.count {
               let provinceDic = provinceArray.object(at: i) as! NSDictionary
               let provinceM = AddressModel.init()
               provinceM.region_name = (provinceDic["region_name"] as? String)
               provinceM.region_id = (provinceDic["region_id"] as! String)
               provinceM.agency_id = (provinceDic["agency_id"] as? String)
               provinceM.parent_id = (provinceDic["parent_id"] as! String)
               provinceM.region_type = (provinceDic["region_type"] as! String)
               provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
               self.dataArray.add(provinceM)
          }
          self.pickerView(addressPicker, didSelectRow: 0, inComponent: 0)
     }
    
     // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
     
     /// 返回列
     ///
     /// - Parameter pickerView: pickerView
     /// - Returns: 列
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
     }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
     /// 返回对应列的行数
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - component: 列
     /// - Returns: 行
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          
        if component == 0{
            return dataArray.count
        }else if component == 1{
            return cityArray.count
        }else{
            return districtArray.count
        }
     }
     
     /// 返回对应行的title
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - row: 行
     ///   - component: 列
     /// - Returns: title
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          var title = ""

        
        pickerDelegate?.selectedAddress(self, selectedProvince, selectedCity, selectedDistrict)
        
        if component == 0{
            let provinceM = dataArray[row] as! AddressModel
            title = provinceM.region_name ?? "未知"
            return title
        }else if component == 1{
            let cityModel = cityArray[row] as! AddressModel
            title = cityModel.region_name ?? "未知"
            return title
        }else{
            let areaModel = districtArray[row] as! AddressModel
            title = areaModel.region_name ?? "未知"
            
            return title
        }
    }
     
     /// 选择列、行
     ///
     /// - Parameters:
     ///   - pickerView: pickerView
     ///   - row: 行
     ///   - component: 列
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            let provinceM = dataArray[row] as! AddressModel
            let cityDicArray = provinceM.childs!
            cityArray.removeAllObjects()
            for j in 0..<cityDicArray.count {
                let cityDic = cityDicArray[j]
                let cityM = AddressModel.init()
                cityM.region_name = (cityDic["region_name"] as? String)
                cityM.region_id = (cityDic["region_id"] as! String)
                cityM.agency_id = (cityDic["agency_id"] as? String)
                cityM.parent_id = (cityDic["parent_id"] as! String)
                cityM.region_type = (cityDic["region_type"] as! String)
                cityM.childs = (cityDic["childs"] as! [NSDictionary])
                cityArray.add(cityM)
            }
            // 默认选择当前省的第一个城市对应的区县
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 1)
            selectedProvince = provinceM
        }else if component == 1 {
            let cityModel = cityArray[row] as! AddressModel
            let areaArray = cityModel.childs!
            districtArray.removeAllObjects()
            for j in 0..<areaArray.count {
                let areaDic = areaArray[j]
                let areaModel = AddressModel.init()
                areaModel.region_name = (areaDic["region_name"] as? String)
                areaModel.region_id = (areaDic["region_id"] as! String)
                areaModel.agency_id = (areaDic["agency_id"] as? String)
                areaModel.parent_id = (areaDic["parent_id"] as! String)
                areaModel.region_type = (areaDic["region_type"] as! String)
                districtArray.add(areaModel)
            }
            selectedCity = cityModel
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 2)
        }else{
            let areaModel = districtArray[row] as! AddressModel
            selectedDistrict = areaModel
        }
        pickerView.reloadAllComponents()
        
    }
}







