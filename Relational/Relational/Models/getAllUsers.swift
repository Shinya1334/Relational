//
//  getAllUsers.swift
//  Relational
//
//  Created by shinya yoshitaka on 2020/02/09.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//

//import SwiftUI
//class getAllUsers : ObservableObject{
//
//    @Published var users = [User]()
//
//    init() {
//
//        let db = Firestore.firestore()
//
//        db.collection("users").getDocuments { (snap, err) in
//
//            if err != nil{
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            for i in snap!.documents{
//
//                let id = i.documentID
//                let name = i.get("name") as! String
//                let pic = i.get("pic") as! String
//                let about = i.get("about") as! String
//
//                if id != UserDefaults.standard.value(forKey: "UID") as! String{
//
//                    self.users.append(User(id: id, name: name, pic: pic, about: about))
//
//                }
//
//            }
//        }
//    }
//}
//
//struct User : Identifiable {
//
//    var id : String
//    var name : String
//    var pic : String
//    var about : String
//}
//struct UserCellView : View {
//
//    var url : String
//    var name : String
//    var about : String
//
//    var body : some View{
//
//        HStack{
//
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
//
//            VStack{
//
//                HStack{
//
//                    VStack(alignment: .leading, spacing: 6) {
//
//                        Text(name).foregroundColor(.black)
//                        Text(about).foregroundColor(.gray)
//                    }
//
//                    Spacer()
//
//                }
//
//                Divider()
//            }
//        }
//    }
//}
