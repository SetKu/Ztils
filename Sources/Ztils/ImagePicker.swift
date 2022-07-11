//
//  ImagePicker.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-11.
//

#if canImport(SwiftUI) && canImport(PhotosUI)
import SwiftUI
import PhotosUI

/// A wrapper for Photo Kit's `PHPickerViewController` enabling retrieval of a UIImage from a user's library without privacy access needed.
@available(iOS 14.0, *)
public struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    public func makeUIViewController(context: Context) -> some UIViewController {
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
    
    final public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { success, error in
                    if let error {
                        fatalError((error as NSError).localizedDescription)
                    }
                    
                    self.parent.image = success as? UIImage
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(image: .constant(nil))
    }
}
#endif
