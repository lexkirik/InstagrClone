//
//  UploadViewController.swift
//  InstagrClone
//
//  Created by Test on 29.01.24.
//

import UIKit
import Photos
import PhotosUI
import Firebase
import FirebaseStorage
import BSImagePicker

class UploadViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    private var selectedImages: [UIImage] = []
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var commentCollage: UITextField!
    @IBOutlet weak var uploadCollage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        let collectionViewWidth = collectionView?.frame.width
        
        let itemWidth = collectionViewWidth!/3 - 1
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "collage")
        collectionView.isUserInteractionEnabled = true
        let gestureCollection = UITapGestureRecognizer(target: self, action: #selector(selectImages))
        collectionView.addGestureRecognizer(gestureCollection)
    }
    
    @objc func chooseImage() {
        var imageCongiguration = PHPickerConfiguration(photoLibrary: .shared())
        imageCongiguration.selectionLimit = 1
        imageCongiguration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let imagePicker = PHPickerViewController(configuration: imageCongiguration)
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else {return}
                DispatchQueue.main.async {
                    self.imageView.image = image
                }

            }
        }
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        var popup = PopupUploadView()
        popupShow(popup: popup)
        let imageLoader = ImageLoader()
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            imageLoader.composePost(data: data, postedBy: Auth.auth().currentUser!.email!, postComment: self.commentText.text!, date: FieldValue.serverTimestamp(), likes: 0) { error in
                if error == .noError {
                    self.imageView.image = UIImage(named: "single.png")
                    self.commentText.text = ""
                    self.tabBarController?.selectedIndex = 0
                } else {
                    self.makeAlert(titleInput: "Error", messageInput: "Error")
                }
                self.popupClose(popup: popup)
            }
        }
    }
    
    func noDownloadingError() {
        self.imageView.image = UIImage(named: "single.png")
        self.commentText.text = ""
        self.tabBarController?.selectedIndex = 0
    }
    
    func popupShow(popup: PopupUploadView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: { () -> Void in
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.view.addSubview(popup)
            })
        })
    }
    
    @objc func popupClose(popup: PopupUploadView) {
        popup.removeFromSuperview()
    }

    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data: UIImage = selectedImages[indexPath.item]
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collage", for: indexPath) as! ImageCell
        cell.image.image = data
        return cell
    }
    
    @objc private func selectImages() {
        let imagePicker = ImagePickerController()
        presentImagePicker(imagePicker, select: { (asset) in
        }, deselect: { (asset) in
             
        }, cancel: { (assets) in
             
        }, finish: { (assets) in
             
            self.selectedImages = []
            let options: PHImageRequestOptions = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
 
            for asset in assets {
                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
                    self.selectedImages.append(image!)
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    @IBAction func uploadCollageClicked(_ sender: Any) {
        print("tapped button upload collage")
    }
    
}

private class ImageCell: UICollectionViewCell {
    var image: UIImageView!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
     
    private func setupViews() {
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        addSubview(image)
    }
}
