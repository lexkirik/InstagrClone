//
//  UploadViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit
import Photos
import PhotosUI

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        var imageCongiguration = PHPickerConfiguration(photoLibrary: .shared())
        imageCongiguration.selectionLimit = 1
        imageCongiguration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let imagePicker = PHPickerViewController(configuration: imageCongiguration)
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
        // imagePicker using .photoLibrary will be deprecated soon
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
    }
    
    // imagePicker using .photoLibrary will be deprecated soon
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        imageView.image = info[.originalImage] as? UIImage
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
//                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "publc.image") { <#URL?#>, <#Error?#> in
//                    <#code#>
//                }
            }
        }
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
    }
    


}
