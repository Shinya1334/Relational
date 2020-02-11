//
//  SignChangeView.swift
//  Relational
//
//  Created by 大城祐介 on 2020/02/11.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct SignChangeView: View {
    var currentuser = Firebase.Auth.auth().currentUser
    let db = Firestore.firestore()
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    //    @ObservedObject private var vm = SignInViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var willChange = true
    @State private var decideChange = false
    @State private var password : String = ""
    @State private var oldEmailAddress: String = ""
    @State private var olddispname: String = ""
    @State private var emailAddress: String = ""
    @State private var newdispname: String = ""
    
    @State private var showPasswordAlert = false
    @State var showSuccessAlert = false

    @State var errorText: String = ""
    
    var passwordResetAlert: Alert {
        Alert(title: Text("Reset your password"), message: Text("Please click the link in the password reset email sent to you"), dismissButton: .default(Text("Dismiss")){
            })
    }
    var successAlert: Alert {
        Alert(title: Text("Success"), message: Text("changed your profile"), dismissButton: .default(Text("Dismiss")){
            })}
    var body: some View {
        VStack {
            Text("Profile")
                .fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(spacing: 10){
                Text("User name : \(UserDefaults.standard.value(forKey: "UserName")as! String)").font(.title)
                Text("email addressd : \((self.currentuser?.email)!)")
            
                TextField("\(UserDefaults.standard.value(forKey: "UserName")as! String)", text: $newdispname)
                Divider()
                TextField("\((self.currentuser?.email)!)", text: $emailAddress)
                Divider()
            }
            VStack{
//                Text("now Password").font(.title).fontWeight(.thin)
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                Text("now Password").font(.title)
                
                SecureField("Enter a password", text: $password)
                Divider()
                Button(action: {
                    
                    Auth.auth().sendPasswordReset(withEmail: (self.currentuser?.email)!) { error in
                        if let error = error {
                            self.errorText = error.localizedDescription
                            return
                        }
                        self.showPasswordAlert.toggle()
                    }
                }
                ) {
                    Text("change Password")
                }
                Button(action: {
                    if(self.willChange){
                        self.SignChange(email:self.emailAddress, username: self.newdispname, pass: self.password)
                    }
                })
                {
                    Text("change Profile")
                }.alert(isPresented: $showSuccessAlert,content: {self.successAlert})
                Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                {
                    Text("Back Home")
                }
            }
        }
    }

    func SignChange(email: String, username: String, pass: String) {
        let user = Auth.auth().currentUser
        if self.emailAddress != ""{
            let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: pass)
            user?.reauthenticate(with: credential) {(result, error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                    return
                } else {
                    user!.updateEmail(to: email) { (error) in
                        if let error = error {
                            self.errorText = error.localizedDescription
                            return
                        }else{
                            self.showSuccessAlert = true
                        }
                    }
                }
            }
        }
        if self.newdispname != ""{
            let uid = user?.uid
            db.collection("users").document(uid!).setData([
                "name":username,
                "uid":uid!]){ error in
                    if let error = error {
                        self.errorText = error.localizedDescription
                        return
                    } else{
                        UserDefaults.standard.set(username, forKey: "UserName")
                        self.showSuccessAlert = true
                    }
                    
            }
        }
    }
}

//            guard let user = authResult?.user, error == nil else {
//
//                let errorText: String  = error?.localizedDescription ?? "unknown error"
//                self.errorText = errorText
//
//                return
//            }
//
//            Auth.auth().currentUser?.sendEmailVerification { (error) in
//                if let error = error {
//                    self.errorText = error.localizedDescription
//                    return
//                }
////                self.showAlert.toggle()
//                let uid = Auth.auth().currentUser?.uid
//                db.collection("users").document(uid!).setData(["name":username,"uid":uid!]) { (err) in
//
//                    if err != nil{
//
//                        print((err?.localizedDescription)!)
//                        return
//                    }
//
//                    UserDefaults.standard.set(true, forKey: "status")
//
//                    UserDefaults.standard.set(username, forKey: "UserName")
//
//                    UserDefaults.standard.set(uid, forKey: "UID")
//
//                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                }
////                self.shouldAnimate = false
//                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                changeRequest?.displayName = username
//                changeRequest?.commitChanges { (error) in
//                    if let error = error {
//                        self.errorText = error.localizedDescription
//                        return
//                    }
//                }
//
//            }
//
//            print("\(user.email!) created")
//
//        }
//
//
struct SignChangeView_Previews: PreviewProvider {
    static var previews: some View {
        SignChangeView()
    }
}
