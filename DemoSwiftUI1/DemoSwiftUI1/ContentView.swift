//
//  ContentView.swift
//  DemoSwiftUI1
//
//  Created by study on 2022/7/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }
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
 
 修改UI的方法：
 1. 可以使用代码进行修改UI
    * 可以使用修饰符，多个修饰符使用链式，垂直堆叠。
    * 修饰符：就是OC中的属性。如 .font(.title) .foregroundColor(.green)
 2. 可以单击代码中的UI, 选择“Show SwiftUI Inspector” 来修改UI
 3. 可以使用检查器来修改UI
    * 1. 在画布中，按住Command键，单击要修改的UI,选择“Show SwiftUI Inspector ”

 创建 SwiftUI 视图：
 1. 在 视图的 body 属性中写：
    * 内容
    * 布局
    * 行为
 2. body 属性只返回单个视图。
 所以多个视图的时候，需要将多个视图组合在一起，并嵌套到堆栈中。
 这些视图可以水平、垂直或背对前地将视图分组在一起。
 
 
 
 SwiftUI 的一些属性：
 1. VStack: 垂直控件
 2. HStack: 水平控件
 3. 如果想让UI的布局占设备的全部宽度，可以在水平控件HStack中添加一个Spacer(),来容纳两个文本视图。
 */
