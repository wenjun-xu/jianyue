//
//  ContentView.swift
//  DemoSwiftUI1
//
//  Created by study on 2022/7/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/**
 一个 SwiftUI 视图文件 会有2个结构。
 1. 第一个结构 是编写视图的内容和布局的。
 2. 第二个结构是 声明这个视图的预览。
 
 画布：
 在右侧，有一个画布，这个画布会显示 UI 界面。
 如果没有显示这个画布，点击 编辑器 -> 画布 来显示它。
 当你修改当前页面的UI时，画布会自动更新。
 
 */
