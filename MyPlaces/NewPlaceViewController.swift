//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Алина on 02.06.2022.
//

import UIKit
import PhotosUI

class NewPlaceViewController: UITableViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
 
    @IBOutlet weak var imageOfPlace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                
                // TODO: chooseImagePicker
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                // TODO: chooseImagePicker
//                self.chooseImagePicker(source: .photoLibrary)
                // .photolibrary will be deprecated потому используем PhotosUI, но тут нельзя редактировать фото (((
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 1
                configuration.filter = .images
                configuration.filter = .any(of: [.livePhotos, .images])
                configuration.preferredAssetRepresentationMode = .automatic
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)


            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
}


extension NewPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
// MARK: Work with image
//extension NewPlaceViewController {
extension NewPlaceViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlace.image = info[.editedImage] as? UIImage
        imageOfPlace.contentMode = .scaleAspectFill
        imageOfPlace.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
     //       imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}


extension NewPlaceViewController {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       picker.dismiss(animated: true, completion: nil)
       
       for result in results {
          result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
             if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self.imageOfPlace.image = image
                    self.imageOfPlace.contentMode = .scaleAspectFill
                    self.imageOfPlace.clipsToBounds = true
                }
             }
          })
       }
    }
}

