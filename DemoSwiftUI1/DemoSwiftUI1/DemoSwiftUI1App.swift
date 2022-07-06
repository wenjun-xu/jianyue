//
//  DemoSwiftUI1App.swift
//  DemoSwiftUI1
//
//  Created by study on 2022/7/6.
//

import SwiftUI

@main
struct DemoSwiftUI1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

/**
 这是应用程序的入口点
 在 Xcode 13 及 以上的版本中，类名是 LandmarksApp
 swiftUI 的应用程序生命周期，应该继承至 App .
 body 属性会返回一个或多个场景。这些场景会提供显示内容。
 */
