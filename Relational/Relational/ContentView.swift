
import SwiftUI
import Firebase

struct Indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) ->
        UIActivityIndicatorView {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.startAnimating()
            return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}



struct ContentView: View {
    
    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false
    @State var selection: Int? = nil
    @State var viewState = CGSize.zero
    @State var MainviewState =  CGSize.zero
    
    var body: some View {
        
        ZStack{
            
            if Auth.auth().currentUser != nil {
                
                VStack{
                    
                    NavigationView{
                        
                        HomeView()
                            .environmentObject(MainObservable())
                    }
                }
                
            }
                
            else {
                VStack {
                    Spacer()
                    VStack(spacing:20) {
                        
                        Button(action: {self.signUpIsPresent = true}){
                            Text("Sign Up")
                            
                        }.sheet(isPresented: self.$signUpIsPresent){
                            
                            SignUpView()
                        }
                        
                        Button(action: {self.signInIsPresent = true}){
                            
                            Text("Sign In")
                            
                        }.sheet(isPresented: $signInIsPresent) {
                            
                            SignIn(onDismiss:{
                                self.viewState = CGSize(width: screenWidth, height: 0)
                                self.MainviewState = CGSize(width: 0, height: 0)
                                
                            })}}
                    Spacer()
                    
                }.edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom)
                    .offset(x:self.viewState.width).animation(.spring())
            }
            
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class MainObservable: ObservableObject {
    @Published var rooms = [Room]()
    @Published var norecetns = false
    
    init() {
        let db = Firestore.firestore()
        db.collection("room").addSnapshotListener{ (snap,error) in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                let id = i.document.documentID
                self.rooms.append(Room(id:id))
                
            }
        }
    }
}
struct Room : Identifiable {
    var id : String
}
struct Recent : Identifiable {
    var id : String
    var name : String
    var lastmsg : String
    var time : String
    var date : String
    var stamp : Date
}
