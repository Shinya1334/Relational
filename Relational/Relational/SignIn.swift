//
//  SignIn.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/02.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInView : View {

    @EnvironmentObject var session: Session
    @ObservedObject private var vm = SignInViewModel()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var flag = false
    @State var result = ""

    var body: some View {
        NavigationView{
            VStack {
                TextField("User ID", text: $vm.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(UITextAutocapitalizationType.none)

                SecureField("Password", text: $vm.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if (!vm.validationText.isEmpty) {
                    Text(vm.validationText)
                        .font(.caption)
                        .foregroundColor(Color.red)
                }
                Button(action: {
    //                let user = Auth.auth().currentUser;
    //                    .sink(receiveCompletion: { completion in
    //                        print("receiveCompletion:", completion)
    //                    }, receiveValue: { user in
    //                        print("userId:", user.id)
    //                        self.session.user = user
    //                        self.session.isSignIn = true
    //                    })
                    self.result = self.vm.SignIn()
                    let user = Auth.auth().currentUser;
                    if ((user) != nil) {
                        self.flag = true
                      } else {
                        self.flag = false
                      }
                })
                {
                    Text("Sign in")
                }
                    NavigationLink(destination: LandmarkDetail(), isActive: $flag){ EmptyView() }
    //            NavigationLink(destination: LandmarkDetail(), isActive: $flag){
    //                Text("Sign in")
    //            }
            }
//            .disabled(!vm.canSignIn)
        }.padding(.horizontal,20)
    }
}
//        NavigationView{
//        VStack {
//            TextField("メールアドレスを入力してください", text: $email)
//                .padding(.all, 30)
//            //Text("\(email)")
//
//            SecureField("Password", text: $password)
//                .padding(.all, 30)
//            //Text("\(password)")
//
//            if (error) {
//                Text("ahhh crap")
//            }
//            Button(action: {
//                Auth.auth().signIn(withEmail: self.email, password: self.password) { (user, error) in
//                if let error = error {
//                    print(error.localizedDescription)
////                    self.lblCaution.text = "☹️\n\(error.localizedDescription)"
//                }
//                else if user != nil {
//                    self.flag = true
////                    self.lblCaution.text = "😍\n Logged in with : \(user.email!)"
//                }
//                }})
//            {
//                Text("Sign in")
//            }
//
//            NavigationLink(destination: LandmarkDetail(), isActive: $flag) { EmptyView() }
//        }
//    }

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
         .environmentObject(Session())
    }
}
