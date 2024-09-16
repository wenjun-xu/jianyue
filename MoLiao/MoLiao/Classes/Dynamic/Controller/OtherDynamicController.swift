//
//  OtherDynamicController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/28.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class OtherDynamicController: BaseViewController, MomentCellDelegate, UITextFieldDelegate {
    fileprivate var commentArr:NSMutableArray!
    let cellIdentifer = "momentCell"
    
    var momentList = NSMutableArray()
    var aTableView: UITableView!
    var coverImageView: UIImageView!
    var headImageView: UIImageView!
    
    var textField: UITextField!
    var totalKeybordHeight: CGFloat!
    var isDelete: Int!
    
    var selectIndexPath:IndexPath!
    
    private var keyboardView:UIView!
    private var textView:UITextView!
    private var tishiLabel:UILabel!
    private var fabuButton:UIButton!
    private var isReply:Bool!
    private var selectToUserName:String!
    var selfTitle:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selfTitle + "的动态"
        self.view.backgroundColor = UIColor.white
        
        loadViewFrame()
        loadViewData()
    }
    
    @objc func rightClick() {
        let vc = WJDynamicNewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // 加载视图
    func loadViewFrame() {
        
        self.isDelete = 0
        
        // 表格
        self.aTableView = UITableView(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kScreenHeight - kNavH - kStatusBarH ))
        self.aTableView.backgroundColor = UIColor.clear
        self.aTableView.separatorStyle = .singleLine
        self.aTableView.separatorColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.aTableView.separatorInset = .zero
        self.aTableView.dataSource = self
        self.aTableView.delegate = self
        self.aTableView.estimatedRowHeight = 0
        self.aTableView.tableFooterView = UIView()
        self.aTableView.register(MomentCell.self, forCellReuseIdentifier: cellIdentifer)
        self.view.addSubview(self.aTableView)
        
        // 评论视图
        self.textField = UITextField()
        textField.returnKeyType = .done
        textField.delegate = self
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        textField.layer.borderWidth = 1
        textField.keyboardAppearance = .default
        
        if  textField.isFirstResponder {
            textField.resignFirstResponder()
            textField.becomeFirstResponder()
        }
        
        textField.frame = CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 40)
        UIApplication.shared.keyWindow?.addSubview(textField)
        
//        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        
        // 添加键盘弹出通知，获取高度
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func buildModelCommonByJson(_ json: JSON){
        print("json.arrayValue===",json.arrayValue)
        for item in json.arrayValue {
            let model = Moment()
            model.text = item["text"].stringValue
            model.location = item["location"].stringValue
            model.userName = item["userName"].stringValue
            model.userThumbPath = item["userThumbPath"].stringValue
            model.praiseNameList = item["praiseNameList"].stringValue
            model.isFullText = item["isFullText"].boolValue
            model.isPraise = item["isPraise"].boolValue
            model.singleWidth = 500
            model.singleHeight = 315
            model.fileCount = CGFloat(item["fileCount"].intValue)
            model.time = item["time"].stringValue
            let commentArr = NSMutableArray()
            for j:Int in 0..<item["commentList"].arrayValue.count {
                let mmdel = Comment()
                mmdel.text = item["commentList"][j]["text"].stringValue
                mmdel.time = item["commentList"][j]["time"].stringValue
                mmdel.userName = item["commentList"][j]["userName"].stringValue
                mmdel.toUserName = item["commentList"][j]["toUserName"].stringValue
                commentArr.add(mmdel)
            }
            model.commentList = commentArr
            self.momentList.add(model)
        }
    }
    // 加载数据
    func loadViewData() {
        let strDataPath = Bundle.main.path(forResource: "otherDynamic", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        buildModelCommonByJson(json["data"])
    }
    
    //MARK： Table cell delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.momentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? MomentCell
        if (cell == nil) {
            cell = MomentCell(style: .default, reuseIdentifier: cellIdentifer)
        }
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.white
        cell?.moment = self.momentList[indexPath.row] as? Moment
        cell?.delegate = self
        cell?.tag = indexPath.row
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let moment: Moment = self.momentList.object(at: indexPath.row) as! Moment
        return moment.rowHeight ?? 200
    }
    
    
    //MARK: 发布动态
    @objc func addMoment() {
        
        print("新增")
    }
    
    //MARK: MomentCellDelegate
    @objc func didClickProfile(cell: MomentCell) {
        
        print("点击用户头像")
    }
    
    // 点赞
    func didLikeMoment(cell: MomentCell) {
        
        print("点赞")
        let moment = cell.moment
        var tempAry = NSMutableArray()
        if moment?.praiseNameList != nil {
            
            tempAry = NSMutableArray(array: (moment?.praiseNameList?.components(separatedBy: "，"))!)
            
        }
        
        if (moment?.isPraise)! {
            
            moment?.isPraise = false
            tempAry.remove("小宝")
        }
        else {
            moment?.isPraise = true
            tempAry.add("小宝")
        }
        
        let tempStr = NSMutableString()
        let count = tempAry.count
        
        for i in 0..<count {
            if i == 0 {
                tempStr.append(tempAry.object(at: i) as! String)
            }
            else {
                tempStr.append(("，" + (tempAry.object(at: i) as! String)))
            }
        }
        moment?.praiseNameList = tempStr as String
        self.momentList.replaceObject(at: cell.tag, with: moment as Any)
        self.aTableView.reloadData()
    }
    
    
    // 查看全文、 收起
    func didSelectFullText(cell: MomentCell) {
        
        print("全文、收起")
        
        let indexPath = self.aTableView.indexPath(for: cell)
        
        let moment:Moment = (self.momentList[indexPath!.row] as? Moment)!
        moment.isFullText = !(moment.isFullText ?? false)
        
        self.momentList.replaceObject(at: (indexPath?.row)!, with: moment)
        
        self.aTableView.reloadRows(at: [indexPath!], with: .none)
    }
    
    // 删除
    func didDeleMoment(cell: MomentCell) {
        
        
        print("删除")
        
        let alert = UIAlertController(title: "确定删除吗？", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
            
            // 取消
        }))
        
        alert.addAction(UIAlertAction(title: "删除", style: .cancel, handler: { (action) in
            
            self.isDelete = 1
            // 删除
            self.momentList.remove(cell.moment)
            self.aTableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func didSelectComment(cell: MomentCell, model: Comment) {
        selectToUserName = model.userName
        print("点击回复")
        isReply = true
        textField.becomeFirstResponder()
        textField.frame = CGRect(x: 0, y: kSCREEN_HEIGHT - 120, width: kSCREEN_WIDTH, height: 40)
        textField.placeholder = "回复："
        textField.becomeFirstResponder()
        
        let indexPath = self.aTableView.indexPath(for: cell)
        self.selectIndexPath = indexPath!
        
        let window = UIApplication.shared.keyWindow
        let rect = cell.superview?.convert(cell.frame, to: window)
        
        let delta = (rect?.maxY)! - (kSCREEN_HEIGHT - totalKeybordHeight)
        var offset = self.aTableView.contentOffset
        offset.y += delta
        
        if offset.y < 0 {
            offset.y = 0
        }
        self.aTableView.setContentOffset(offset, animated: true)
    }
    
    // 评论
    func didAddComment(cell: MomentCell) {
        print("评论")
        isReply = false
        cell.menuView.show = false
        textField.frame = CGRect(x: 0, y: kSCREEN_HEIGHT - 120, width: kSCREEN_WIDTH, height: 40)
        textField.placeholder = "评论："
        textField.becomeFirstResponder()
        
        let indexPath = self.aTableView.indexPath(for: cell)
        self.selectIndexPath = indexPath!
        
        let window = UIApplication.shared.keyWindow
        let rect = cell.superview?.convert(cell.frame, to: window)
        
        let delta = (rect?.maxY)! - (kSCREEN_HEIGHT - totalKeybordHeight)
        var offset = self.aTableView.contentOffset
        offset.y += delta
        
        if offset.y < 0 {
            offset.y = 0
        }
        self.aTableView.setContentOffset(offset, animated: true)
    }
    
    
    // 点击高亮文字
    func didClickLink(link: MLLink, linkText: String) {
        
        print("点击a高亮文字： " + linkText )
    }
    
    //MARK: 视图操作
    // textfiled Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text?.count != 0 {
            
            textField.resignFirstResponder()
            
            let moment: Moment = self.momentList[selectIndexPath.row] as! Moment
            print("selectIndexPath==",selectIndexPath.row)
            print("selectToUserName===",selectToUserName)
            let comment = Comment()
            comment.userName = "徐文俊"
            if isReply {
                comment.toUserName = selectToUserName
            }else {
                comment.toUserName = ""
            }
            comment.text = textField.text
            comment.time = "1487649503"
            moment.commentList?.add(comment)
            self.momentList.replaceObject(at: selectIndexPath.row, with: moment)
            self.aTableView.reloadRows(at: [self.selectIndexPath], with: .none)
            textField.text = ""
            textField.placeholder = nil
            return true
        }
        return false
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        
        let dict = notification.userInfo
        let rect = dict!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        
        var textFieldRect = CGRect(x: 0, y: rect.origin.y - 40, width: rect.size.width, height: 40)
        if rect.origin.y == kSCREEN_HEIGHT {
            
            textFieldRect = rect
        }
        
        UIView.animate(withDuration: 0.3) {
            self.textField.frame = textFieldRect
        }
        
        let height = rect.size.height + 40.0
        if self.totalKeybordHeight != height {
            
            self.totalKeybordHeight = height
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        textField.resignFirstResponder()
        textField.placeholder = nil
    }
    
}
