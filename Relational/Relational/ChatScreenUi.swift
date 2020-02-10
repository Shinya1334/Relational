////
////  ChatScreenUi.swift
////  Relational
////
////  Created by shinya yoshitaka on 2019/11/27.
////  Copyright © 2019 shinya yoshitaka. All rights reserved.
////
//
////import FirebaseDatabase
//import Firebase
//import SwiftUI
//
//
////struct ChatScreenUi: View {
//////    var snap: DataSnapshot!
////    @State var user = Auth.auth().currentUser
////    @State var name: String = ""
////    @State var typedmessage = ""
////    @ObservedObject var msg = observer()
////    var body: some View {
////        VStack{
////            List(msg.msgs){loop in
////                if loop.name == self.user?.email{
////                    MsgRow(msg: loop.msg, myMsg: true, user: loop.name)
////
////                }
////                else{
////                    MsgRow(msg: loop.msg, myMsg: false, user: loop.name)
////
////                }
////
////            }.navigationBarTitle("Chat", displayMode: .inline)
////
////            HStack{
////                TextField("Message", text:
////                    $typedmessage).textFieldStyle(RoundedBorderTextFieldStyle())
////                Button(action: {
////                    self.name = (self.user?.email)!
////                    self.msg.addMsg(msg: self.typedmessage, user: self.name)
////                    self.typedmessage=""
////                }){
////                Text("send")
////        }
////        }.padding()
////    }
////}
////
////struct ChatScreenUi_Previews: PreviewProvider {
////    static var previews: some View {
////        ChatScreenUi()
////    }
////}
////class observer : ObservableObject {
////    var name = ""
////    @Published var msgs = [datatype]()
////    @Published var norecetns = false
////
////    init(){
////        let db = Firestore.firestore()
////        db.collection("msgs").order(by: "date", descending: true).addSnapshotListener{(snap, err)
////            in
////            if err != nil{
////                print((err?.localizedDescription)!)
////                return
////            }
////                       if snap!.isEmpty{
////
////                           self.norecetns = true
////                       }
////
////            for loop in snap!.documentChanges{
////
////                if loop.type == .added{
////                    let name = loop.document.get("name") as! String
////                    let msg = loop.document.get("msg") as! String
////                    let id = loop.document.documentID
////                    let stamp = loop.document.get("date") as! Timestamp
////                    let formatter = DateFormatter()
////                     formatter.dateFormat = "dd/MM/yy"
////                     let date = formatter.string(from: stamp.dateValue())
////
////                     formatter.dateFormat = "hh:mm a"
////                     let time = formatter.string(from: stamp.dateValue())
////                    self.msgs.append(datatype(id: id, name: name, msg: msg))
////                }
////                if loop.type == .modified{
////
////                    let id = loop.document.documentID
////                    let stamp = loop.document.get("date") as! Timestamp
////
////                    let formatter = DateFormatter()
////                    formatter.dateFormat = "dd/MM/yy"
////                    let date = formatter.string(from: stamp.dateValue())
////
////                    formatter.dateFormat = "hh:mm a"
////                    let time = formatter.string(from: stamp.dateValue())
////                }
////            }
////        }
////    }
////    func addMsg(msg: String,user: String){
////        let db = Firestore.firestore()
////        db.collection("msgs").addDocument(data:["msg":msg,"name": user]){(err) in
////            if err != nil{
////                print((err?.localizedDescription)!)
////                return
////            }
////            print("success")
////
////        }
////    }
////}
////}
////struct datatype : Identifiable{
////    var id : String
////    var name : String
////    var msg : String
////}
////struct MsgRow : View {
////
////    var msg = ""
////    var myMsg = false
////    var user = ""
////
////    var body : some View{
////        HStack{
////
////            if myMsg{
////                Spacer()
////                Text(msg).padding(8).background(Color.red).cornerRadius(6)
////                    .foregroundColor(.white)
////            }else{
////                Text(msg).padding(8).background(Color.green).cornerRadius(6)
////                .foregroundColor(.white)
////                Text(user)
////                Spacer()
////            }
////        }
////    }
////}
//
//
//struct ChatScreenUi : View {
//
//    var name : String
//    var pic : String
//    var uid : String
//    @Binding var chat : Bool
//    @State var msgs = [Msg]()
//    @State var txt = ""
//    @State var nomsgs = false
//
//    var body : some View{
//
//        VStack{
//
//
//            if msgs.count == 0{
//
//                if self.nomsgs{
//
//                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
//
//                    Spacer()
//                }
//                else{
//
//                    Spacer()
//                    Indicator()
//                    Spacer()
//                }
//
//
//            }
//            else{
//
//                ScrollView(.vertical, showsIndicators: false) {
//
//                    VStack(spacing: 8){
//
//                        ForEach(self.msgs){i in
//
//
//                            HStack{
//
//                                if i.user == UserDefaults.standard.value(forKey: "UID") as! String{
//
//                                    Spacer()
//
//                                    Text(i.msg)
//                                        .padding()
//                                        .background(Color.blue)
//                                        .clipShape(ChatBubble(mymsg: true))
//                                        .foregroundColor(.white)
//                                }
//                                else{
//
//                                    Text(i.msg).padding().background(Color.green).clipShape(ChatBubble(mymsg: true)).foregroundColor(.white)
//
//                                    Spacer()
//                                }
//                            }
//
//                        }
//                    }
//                }
//            }
//
//            HStack{
//
//                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button(action: {
//
//                    sendMsg(user: self.name, uid: self.uid, pic: self.pic, date: Date(), msg: self.txt)
//
//                    self.txt = ""
//
//                }) {
//
//                    Text("Send")
//                }
//            }
//
//                .navigationBarTitle("(name)",displayMode: .inline)
//                .navigationBarItems(leading: Button(action: {
//
//                    self.chat.toggle()
//
//                }, label: {
//
//                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
//
//                }))
//
//        }.padding()
//        .onAppear {
//
//            self.getMsgs()
//
//        }
//    }
//
//    func getMsgs(){
//
//        let db = Firestore.firestore()
//
//        let uid = Auth.auth().currentUser?.uid
//
//        db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
//
//            if err != nil{
//
//                print((err?.localizedDescription)!)
//                self.nomsgs = true
//                return
//            }
//
//            if snap!.isEmpty{
//
//                self.nomsgs = true
//            }
//
//            for i in snap!.documentChanges{
//
//                if i.type == .added{
//
//
//                    let id = i.document.documentID
//                    let msg = i.document.get("msg") as! String
//                    let user = i.document.get("user") as! String
//
//                    self.msgs.append(Msg(id: id, msg: msg, user: user))
//                }
//
//            }
//        }
//    }
//}
//
//struct Msg : Identifiable {
//
//    var id : String
//    var msg : String
//    var user : String
//}
//
//struct ChatBubble : Shape {
//
//    var mymsg : Bool
//
//    func path(in rect: CGRect) -> Path {
//
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
//
//        return Path(path.cgPath)
//    }
//}
//
//func sendMsg(user: String,uid: String,pic: String,date: Date,msg: String){
//
//    let db = Firestore.firestore()
//
//    let myuid = Auth.auth().currentUser?.uid
//
//    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            // if there is no recents records....
//
//            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
//            return
//        }
//
//        if !snap!.exists{
//
//            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
//        }
//        else{
//
//            updateRecents(uid: uid, lastmsg: msg, date: date)
//        }
//    }
//
//    updateDB(uid: uid, msg: msg, date: date)
//}
//
//func setRecents(user: String,uid: String,pic: String,msg: String,date: Date){
//
//    let db = Firestore.firestore()
//
//    let myuid = Auth.auth().currentUser?.uid
//
//    let myname = UserDefaults.standard.value(forKey: "UserName") as! String
//
//    let mypic = UserDefaults.standard.value(forKey: "pic") as! String
//
//    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["name":myname,"pic":mypic,"lastmsg":msg,"date":date]) { (err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            return
//        }
//    }
//
//    db.collection("users").document(myuid!).collection("recents").document(uid).setData(["name":user,"pic":pic,"lastmsg":msg,"date":date]) { (err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            return
//        }
//    }
//}
//
//func updateRecents(uid: String,lastmsg: String,date: Date){
//
//    let db = Firestore.firestore()
//
//    let myuid = Auth.auth().currentUser?.uid
//
//    db.collection("users").document(uid).collection("recents").document(myuid!).updateData(["lastmsg":lastmsg,"date":date])
//
//     db.collection("users").document(myuid!).collection("recents").document(uid).updateData(["lastmsg":lastmsg,"date":date])
//}
//
//func updateDB(uid: String,msg: String,date: Date){
//
//    let db = Firestore.firestore()
//
//    let myuid = Auth.auth().currentUser?.uid
//
//    db.collection("msgs").document(uid).collection(myuid!).document().setData(["msg":msg,"user":myuid!,"date":date]) { (err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            return
//        }
//    }
//
//    db.collection("msgs").document(myuid!).collection(uid).document().setData(["msg":msg,"user":myuid!,"date":date]) { (err) in
//
//        if err != nil{
//
//            print((err?.localizedDescription)!)
//            return
//        }
//    }
//}
