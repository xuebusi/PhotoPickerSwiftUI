//
//  ContentView.swift
//  PhotoPickerSwiftUI
//
//  Created by shiyanjun on 7/22/23.
//

import SwiftUI

/**
 - 在模拟器中选择照片库中默认紫色花朵那张图片时会报错，原因未知（我的xcode版本是14.3.1）
 - 在 stackoverflow 上有人说是xcode版本的问题（在xcode13和xcode15上没有问题，在xcode14和16上有问题）
 */
struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            // 选择单张图片
            SinglePhotosPickerView()
            // 选择多张图片
//            MultiplePhotosPickerView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
