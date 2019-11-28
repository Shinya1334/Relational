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

struct SignUpView: View {
    
    
    
//       @State var maill = ""
//       @State var password = ""
//       @State var isShown = false
        @State var mailAdress = ""
        @State var password = ""
        @State var verifyPassword = ""
//
       var body: some View {
        VStack {
            KeyboardObservingView {
            VStack {
                Text("メールアドレス")
                TextField("メールアドレスを入力してください", text: $mailAdress)
                    .padding(.top, 30)
                    .padding(.bottom, 40.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("パスワード")
                SecureField("パスワードを入力してください", text: $password)
                    .padding(.bottom, 40.0)
                Text("パスワード(確認用)")
                SecureField("上と同じパスワードを入力してください", text: $verifyPassword)
                    .padding(.bottom, 40.0)
            }
            .padding()
            }
            Spacer()

            Button(action: {

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

