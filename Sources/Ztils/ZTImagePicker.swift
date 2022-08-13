//
//  ImagePicker.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-11.
//

#if canImport(SwiftUI) && canImport(PhotosUI) && canImport(UIKit)
import SwiftUI
import PhotosUI

/// A wrapper for Photo Kit's `PHPickerViewController` enabling retrieval of a UIImage from a user's library without privacy access needed.
@available(iOS 14.0, *)
public struct ZTImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let useCamera: Bool
    
    public init(image: Binding<UIImage?>? = nil, useCamera: Bool) {
        self.useCamera = useCamera
        
        if let image = image {
            self._image = image
            return
        }
        
        self._image = .constant(nil)
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        if useCamera {
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.cameraCaptureMode = .photo
            controller.delegate = context.coordinator
            return controller
        }
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final public class Coordinator: NSObject, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ZTImagePicker
        
        public init(_ parent: ZTImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            defer { picker.dismiss(animated: true) }
            
            if let image = info[.editedImage] as? UIImage {
                self.parent.image = image
                return
            }
            
            if let image = info[.originalImage] as? UIImage {
                self.parent.image = image
            }
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            defer { picker.dismiss(animated: true) }
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { success, error in
                    // There is a common error in the iOS simulator where the image with the pink flowers will cause a crash. This is a problem with the simulator, and production code is not supposed to fail this way. This error has been disabled for this reason.
//                    if let error {
//                        fatalError((error as NSError).localizedDescription)
//                    }
                    
                    self.parent.image = success as? UIImage
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct ZTImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ZTImagePicker(image: .constant(nil), useCamera: false)
    }
}
#endif
