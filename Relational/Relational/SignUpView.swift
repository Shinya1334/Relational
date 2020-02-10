import SwiftUI
import Firebase


struct actIndSignup: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var agreeCheck: Bool = false
    @State var errorText: String = ""
    @State private var showAlert = false
    @State private var shouldAnimate = false
    
    var alert: Alert {
        
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.password = ""
            self.username = ""
            self.agreeCheck = false
            self.errorText = ""
            
            })
    }
    
    var body: some View {
        
        VStack {
            
            Text("Sign Up")
                .fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 30)
            
            VStack(spacing: 10) {
                
                Text("Email").font(.title).fontWeight(.thin)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                    TextField("user@domain.com", text: $emailAddress).textContentType(.emailAddress)
                    
                    Divider()
                VStack{

                    Text("Password").font(.title).fontWeight(.thin)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    
                    SecureField("Enter a password", text: $password)
                    
                    Divider()
                    VStack{
                    Text("displayName").font(.title).fontWeight(.thin)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    
                    TextField("displayname", text: $username)
                        Divider()
                        .padding(.bottom)
                    
                    
                    Toggle(isOn: $agreeCheck)
                    {
                        Text("Agree to the Terms and Condition").fontWeight(.thin)
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    
                    Button(action: {
                        
                        if(self.agreeCheck){
                            print("Printing outputs" + self.emailAddress, self.password  )
                            self.shouldAnimate = true
                            self.SignUp(email:self.emailAddress, password:self.password, username: self.username)
                        }
                        else{
                            self.errorText = "Please Agree to the Terms and Condition"
                        }
                    }) {
                        
                        Text("Sign Up").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                        
                    }.background(Color("SignUp_color"))
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    
                        Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).foregroundColor(.red)
                        .padding(10)
                    
                    actIndSignup(shouldAnimate: self.$shouldAnimate)
                }
                }
                Spacer()
                
            }.padding(10)
            
        }.edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)
            
            
            .alert(isPresented: $showAlert, content: { self.alert })
        
    }
    
    
    func SignUp(email: String, password: String, username: String) {
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let user = authResult?.user, error == nil else {
                
                let errorText: String  = error?.localizedDescription ?? "unknown error"
                self.errorText = errorText
                
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                    return
                }
                self.showAlert.toggle()
                let uid = Auth.auth().currentUser?.uid
                db.collection("users").document(uid!).setData(["name":username,"uid":uid!]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    
                    UserDefaults.standard.set(username, forKey: "UserName")
                    
                    UserDefaults.standard.set(uid, forKey: "UID")
                    
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
                self.shouldAnimate = false
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { (error) in
                    if let error = error {
                        self.errorText = error.localizedDescription
                        return
                    }
                }
                
            }
            
            print("\(user.email!) created")
            
        }
        
        
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
