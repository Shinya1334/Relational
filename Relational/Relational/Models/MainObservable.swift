//
//  MainObservable.swift
//  Relational
//
//  Created by shinya yoshitaka on 2020/02/09.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//
//import SwiftUI
//import Firebase
//
//class MainObservable : ObservableObject
//
//@Published var recents = [Recent]()
//@Published var norecetns = false
//
//init() {
//
//    let db = Firestore.firestore()
//    let uid = Auth.auth().currentUser?.uid
//
//    db.collection("users").document(uid!).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            self.norecetns = true
//            return
//        }
//
//        if snap!.isEmpty{
//
//            self.norecetns = true
//        }
//
//        for i in snap!.documentChanges{
//
//            if i.type == .added{
//
//                let id = i.document.documentID
//                let name = i.document.get("name") as! String
//                let pic = i.document.get("pic") as! String
//                let lastmsg = i.document.get("lastmsg") as! String
//                let stamp = i.document.get("date") as! Timestamp
//
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd/MM/yy"
//                let date = formatter.string(from: stamp.dateValue())
//
//                formatter.dateFormat = "hh:mm a"
//                let time = formatter.string(from: stamp.dateValue())
//
//                self.recents.append(Recent(id: id, name: name, pic: pic, lastmsg: lastmsg, time: time, date: date, stamp: stamp.dateValue()))
//            }
//
//            if i.type == .modified{
//
//                let id = i.document.documentID
//                let lastmsg = i.document.get("lastmsg") as! String
//                let stamp = i.document.get("date") as! Timestamp
//
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd/MM/yy"
//                let date = formatter.string(from: stamp.dateValue())
//
//                formatter.dateFormat = "hh:mm a"
//                let time = formatter.string(from: stamp.dateValue())
//
//
//                for j in 0..ImagePicker.Coordinator {
//
//    return ImagePicker.Coordinator(parent1: self)
//}
//
//func makeUIViewController(context: UIViewControllerRepresentableContext) -> UIImagePickerController {
//
//    let picker = UIImagePickerController()
//    picker.sourceType = .photoLibrary
//    picker.delegate = context.coordinator
//    return picker
//}
//
//func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext) {
//
//
//}
//}
//        }
//
//
