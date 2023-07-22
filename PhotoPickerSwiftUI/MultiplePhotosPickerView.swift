//
//  MultiplePhotosPickerView.swift
//  PhotoPickerSwiftUI
//
//  Created by shiyanjun on 7/22/23.
//

import SwiftUI
import PhotosUI

struct MultiplePhotosPickerView: View {
    
    @State private var selectedItem: [PhotosPickerItem] = []
    @State private var selectedPhotoData: [Data] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(selectedPhotoData, id: \.self) { photoData in
                    if let image = UIImage(data: photoData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Photos")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PhotosPicker(selection: $selectedItem, maxSelectionCount: 4, matching: .images) {
                    Image(systemName: "photo.on.rectangle.angled")
                }
            }
        }
        .onChange(of: selectedItem) { newItems in
            for newItem in newItems {
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        selectedPhotoData.append(data)
                    }
                }
            }
        }
    }
}

struct MultiplePhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplePhotosPickerView()
    }
}
