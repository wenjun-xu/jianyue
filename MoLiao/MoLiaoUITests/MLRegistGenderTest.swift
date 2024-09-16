//
//  MLRegistGenderTest.swift
//  MoLiaoUITests
//
//  Created by study on 2019/4/25.
//  Copyright © 2019年 WY. All rights reserved.
//  学习 UITest 地址：https://blog.csdn.net/qrrrq/article/details/82709453

import XCTest

class MLRegistGenderTest: XCTestCase {

    /// 要预制你的数据（数据库写入等等）
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // 启动App
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    // 清除掉你的数据,关掉APP.
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

        func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
     
    
    }

}
