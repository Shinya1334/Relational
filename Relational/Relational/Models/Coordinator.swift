//
//  Coordinator.swift
//  Relational
//
//  Created by shinya yoshitaka on 2020/02/09.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//

//import SwiftUI
//import Firebase
//class Cordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//
//        var parent : ImagePicker
//
//        init(parent1 : ImagePicker) {
//
//            parent = parent1
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//            self.parent.picker.toggle()
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//
//            let image = info[.originalImage] as! UIImage
//
//            let data = image.jpegData(compressionQuality: 0.45)
//
//            self.parent.imagedata = data!
//
//            self.parent.picker.toggle()
//        }
//}
