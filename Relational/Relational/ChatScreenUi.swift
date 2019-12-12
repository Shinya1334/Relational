//
//  ChatScreenUi.swift
//  Relational
//
//  Created by shinya yoshitaka on 2019/11/27.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

//import FirebaseDatabase
import Firebase
import SwiftUI


struct ChatScreenUi: View {
//    var snap: DataSnapshot!
    @State var user = Auth.auth().currentUser
    @State var name: String = ""
    @State var typedmessage = ""
    @ObservedObject var msg = observer()
    var body: some View {
        VStack{
            List(msg.msgs){loop in
                if loop.name == self.user?.email{
                    MsgRow(msg: loop.msg, myMsg: true, user: loop.name)

                }
                else{
                    MsgRow(msg: loop.msg, myMsg: false, user: loop.name)

                }
                
            }.navigationBarTitle("Chat", displayMode: .inline)
        
            HStack{
                TextField("Message", text:
                    $typedmessage).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.name = (self.user?.email)!
                    self.msg.addMsg(msg: self.typedmessage, user: self.name)
                    self.typedmessage=""
                }){
                Text("send")
        }
        }.padding()
    }
}

struct ChatScreenUi_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreenUi()
    }
}
class observer : ObservableObject {
    var name = ""
    @Published var msgs = [datatype]()
    init(){
        let db = Firestore.firestore()
        db.collection("msgs").addSnapshotListener{(snap, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            for loop in snap!.documentChanges{
                
                if loop.type == .added{
                    let name = loop.document.get("name") as! String
                    let msg = loop.document.get("msg") as! String
                    let id = loop.document.documentID
//                                        let name = loop.document.get("name") as! String
//
//                    let msg = loop.document.get("msg") as! String
//                    let id = loop.document.documentID
                    
                    self.msgs.append(datatype(id: id, name: name, msg: msg))
                }
            }
        }
    }
    func addMsg(msg: String,user: String){
        let db = Firestore.firestore()
        db.collection("msgs").addDocument(data:["msg":msg,"name": user]){(err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            print("success")
            
        }
    }
}
}
struct datatype : Identifiable{
    var id : String
    var name : String
    var msg : String
}
struct MsgRow : View {
    
    var msg = ""
    var myMsg = false
    var user = ""
    
    var body : some View{
        HStack{
            
            if myMsg{
                Spacer()
                Text(msg).padding(8).background(Color.red).cornerRadius(6)
                    .foregroundColor(.white)
            }else{
                Text(msg).padding(8).background(Color.green).cornerRadius(6)
                .foregroundColor(.white)
                Text(user)
                Spacer()
            }
        }
    }
}
