//
//  File.swift
//  
//
//  Created by 王小涛 on 2024/4/29.
//

import Photos
import PhotosUI
import SwiftUI

public struct PhotoPicker: UIViewControllerRepresentable {
    public typealias UIViewControllerType = PHPickerViewController
    public let selectionLimit: Int
    @Binding public var selectedImages: [UIImage]

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_: PHPickerViewController, context _: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(selectedImages: $selectedImages)
    }

    public class Coordinator: PHPickerViewControllerDelegate {
        @Binding var selectedImages: [UIImage]

        init(selectedImages: Binding<[UIImage]>) {
            _selectedImages = selectedImages
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard !results.isEmpty else {
                return
            }

            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self?.selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}
