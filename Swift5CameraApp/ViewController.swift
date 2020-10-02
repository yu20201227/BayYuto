//
//  ViewController.swift
//  Swift5CameraApp
//
//  Created by Owner on 2020/10/01.
//

import UIKit
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    PHPhotoLibrary.requestAuthorization{(status) in
            
        switch(status){
        
        case.authorized:
            print("承認されました")
        case.denied:
            print("拒否されました")
        case.notDetermined:
            print("NotDetermined")
        case.restricted:
            print("Rescricted")
        case .limited:
            print("limited")
        @unknown default:
            break
        }
            
        }

    }

    //右下
    @IBAction func openCamera(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.camera
    
    //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
    //変数化（インスタンス化）
        let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else{
            print("エラー")
        }
        
        
        
    }
    
    //カメラのキャンセルが押された時
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func openAlbum(_ sender: Any) {
        
        let sourceType = UIImagePickerController.SourceType.photoLibrary
    
    //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
    //変数化（インスタンス化）
        let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else{
            print("エラー")
        }
        


    }
    
    //撮影が完了した時に呼ばれる（アルバムから画像が選択された時に呼ばれる箇所）
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage{
            
            backImageView.image = pickedImage
            
     //写真の保存
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            picker.dismiss(animated: true, completion: nil)
        }
    

        
}
    //シェアするための機能
    
    @IBAction func share(_ sender: Any) {
        
        let text = "Yuto"
        let image = backImageView.image?.jpegData(compressionQuality: 0.2)
        let items = [text,image] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC,animated: true,completion: nil)
    }
}

