import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct HomeView : View {
    
    @State var myname = UserDefaults.standard.value(forKey: "UserName") as! String
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var room = ""
    @State private var useYellowBackground = false

    var body : some View{
        ZStack{
            Color("bg").edgesIgnoringSafeArea(.top)
            NavigationLink(destination: ChatView(name: myname, room:self.room, chat: self.$chat), isActive: self.$chat) {
                Text("")
        }
        VStack{
            if self.datas.rooms.count == 0{
                Indicator()
            }else{
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 12){
                            ForEach(datas.rooms){i in
                                Button(action:{
                                    self.useYellowBackground.toggle()
                                    self.room = i.id
                                    self.chat.toggle()
                                }){
                                    RecentCellView(name: i.id)

                                }
                            }
                    }.padding()
                }
            }
            }
        }.navigationBarTitle("Home",displayMode: .inline)
            .navigationBarItems(leading:
                Button(action:{
                    self.show.toggle()
                }, label:{
                    Image(systemName: "person.icloud").resizable().frame(width: 25, height: 25)

                })
        ).sheet(isPresented: self.$show){
            newChatView()
        }
    }
    }



struct RecentCellView : View {
    
    var name : String
    
    var body : some View{
        
        HStack{
            
            VStack{

                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name).foregroundColor(.black).background(Color("bg"))
                    }
                    
                    Spacer()
                }
                
                Divider()
            }
        }
    }
}

struct newChatView : View {
    
    @ObservedObject var datas = getAllUsers()
    
    var body : some View{
        
        VStack(alignment: .leading){

                if self.datas.users.count == 0{
                    
                    Indicator()
                }
                else{
                    
                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 12){
                            
                            ForEach(datas.users){i in
                                    UserCellView(name: i.name)
      
                            }
                            
                        }
                        
                    }
              }
        }.padding()
    }
}
class getAllUsers : ObservableObject{
    @Published var users = [User]()
        init() {
            
            let db = Firestore.firestore()
            
            db.collection("users").getDocuments { (snap, err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                for i in snap!.documents{
                    let id = i.documentID
                    let name = i.get("name") as! String
                    self.users.append(User(id: id, name: name))
            }
        }
    }
}
struct User : Identifiable {
        var id :String
        var name : String
}
struct UserCellView : View {
    
    var name : String
    
    var body : some View{
        
        HStack{
            
            VStack{

                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                
                Divider()
            }
        }
    }
}
struct ChatView : View {
    var name : String
    var room : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body : some View{
        
        VStack{
            if msgs.count == 0{
                
                if self.nomsgs{
                    
                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    
                    Spacer()
                }
                else{
                    
                    Spacer()
                    Indicator()
                    Spacer()
                }

                
            }
            else{
                ScrollView(.vertical) {
                    
                    VStack(spacing: 8){
                        
                        ForEach(self.msgs){i in

                                if i.user == UserDefaults.standard.value(forKey: "UserName") as! String{
                                MsgRow(msg: i.msg, myMsg: true, user: i.user)
    
                                }
                                else{
                                    MsgRow(msg: i.msg, myMsg: false, user: i.user)
                            }

                        }
                    }
                }
            }
            
            HStack{
                TextField("Enter Message", text: self.$txt)
                    .foregroundColor(Color.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    sendMsg(user: UserDefaults.standard.value(forKey: "UserName") as! String, date: Date(), msg: self.txt,room: self.room)
                    self.txt = ""
                }) {
                    Text("Send")
                }
            }
            .navigationBarTitle("\(self.room)",displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.chat.toggle()
                }, label: {
                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                }))
        }.padding()
        .onAppear {
        
            self.getMsgs(room:self.room)
                
        }
    }
    
    func getMsgs(room: String){
        
        let db = Firestore.firestore()
        db.collection("room").document("\(room)").collection("msg").order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{
                
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    let user = i.document.get("name") as! String
                    
                    self.msgs.append(Msg(id: id, msg: msg, user: user))
                }

            }
        }
    }
}
struct Msg : Identifiable {
    
    var id : String
    var msg : String
    var user : String
}

struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

func sendMsg(user: String,date: Date,msg: String,room: String){
    
    let db = Firestore.firestore()
    
    db.collection("room").document("\(room)").collection("msg").getDocuments { (snap, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)

            return
        }
    }
    
    updateDB( msg: msg, date: date,room: room)
}

func setRecents(user: String,uid: String,msg: String,date: Date){
    
    let db = Firestore.firestore()
        
    let myname = UserDefaults.standard.value(forKey: "UserName") as! String
    
    
    db.collection("room").document("ie").collection("msg")
        .addDocument(data:["name": myname, "msg":msg,"date": date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(uid: String,date: Date){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).updateData(["date":date])
    
     db.collection("users").document(myuid!).collection("recents").document(uid).updateData(["date":date])
}

func updateDB(msg: String,date: Date,room: String){
    
    let db = Firestore.firestore()
    let myname = UserDefaults.standard.value(forKey: "UserName") as! String

    
    db.collection("room").document("\(room)").collection("msg")
        .addDocument(data:["name": myname, "msg":msg,"date": date]) {(err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
}
struct MsgRow : View {

    var msg = ""
    var myMsg = false
    var user = ""

    var body : some View{
        HStack{
            Group{
            if myMsg{
                Spacer()
                Text(msg).padding(8).background(Color("thin_blue")).clipShape(ChatBubble(mymsg: myMsg))
                    .foregroundColor(.black)
            }else{
                Text(msg).padding(8).background(Color.green).clipShape(ChatBubble(mymsg: myMsg))
                .foregroundColor(.black)
                Text(user).font(.system(size: 10)).foregroundColor(.gray)
                Spacer()
            }
            }
        }
    }
}
struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
