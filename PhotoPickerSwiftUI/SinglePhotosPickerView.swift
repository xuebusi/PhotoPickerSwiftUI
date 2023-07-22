//
//  SinglePhotosPickerView.swift
//  PhotoPickerSwiftUI
//
//  Created by shiyanjun on 7/22/23.
//

import SwiftUI
import PhotosUI

struct SinglePhotosPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    var body: some View {
        VStack {
            if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
            }
            
            PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
                Label("选择一张照片", systemImage: "photo")
            }
            .tint(.purple)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                    }
                }
            }
        }
        .navigationTitle("Photo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SinglePhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePhotosPickerView()
    }
}
