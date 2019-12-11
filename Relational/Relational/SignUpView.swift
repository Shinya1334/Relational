//
//  LoginView.swift
//  Relational
//
//  Created by 安座間一喜 on 2019/11/26.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Foundation
import KeyboardObserving
import Firebase

struct SignUpView: View {
    var verified = Firebase.Auth.auth().currentUser?.isEmailVerified
    @State var mailAdress: String = ""
    @State var password: String = ""
    @State var verifyPassword: String = ""
    
       var body: some View {
//        let someNumberProxy = Binding<String>(
//             get: { String(format: "%.02f", String(self.mailAdress)) },
//             set: {
//                if let value = String: $0 {
//                     self.someNumber = value.doubleValue
//                 }
//             }
//         )
        VStack {
            KeyboardObservingView {
            VStack {
                Text("メールアドレス")
                TextField("メールアドレスを入力してください", text: $mailAdress)
                    .padding(.top, 30)
                    .padding(.bottom, 40.0)
                //Text("\(mailAdress)")
                SecureField("パスワードを入力してください", text: $password)
                    .padding(.bottom, 40.0)
                Text("パスワード(確認用)")
                //Text("\(password)")
                SecureField("上と同じパスワードを入力してください", text: $verifyPassword)
                    .padding(.bottom, 40.0)
                
            }
            .padding()
                
            }
            Spacer()

            Button(action: {
 
                Auth.auth().createUser(withEmail: "\(self.mailAdress)", password: "\(self.password)") { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    else if let user = user {
                        print(user)
                    }
                }
                if(!self.verified!){
                    Firebase.Auth.auth().currentUser!.sendEmailVerification()
                }
                }) {
                Text("確認メールを送る")
            }
            Spacer()
            }
        }
    
    
//           VStack {
//            Text("メールアドレスを入力して下さい")
//                .font(.system(size: 25))
//
//            HStack {
//                TextField(" Enter some text", text: $maill)
//                    .border(Color.black)
//                    .font(.system(size: 25))
//                .padding()
//            }
//
//            Text("パスワードを入力して下さい")
//                .font(.system(size: 25))
//
//
//            HStack {
//                TextField(" Enter some text", text: $password)
//                    .border(Color.black)
//                    .font(.system(size: 25))
//                .padding()
//            }
//
//            Button(action: {
//                self.isShown = true
//            }) {
//                Text("Sign Up")
//                    .font(.system(size: 25))
//            }
////            .actionSheet(isPresented: $isShown, content: {
////                            ActionSheet(
////                                title: Text("サインしますか"),
////                                buttons: [
////                                    .default(Text("はい")),
////                              .destructive(Text("いいえ")),
////                              .cancel()]
////                        )
////                    })
//        }
//    }
}

           //.padding()
           //.font(.title)

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

