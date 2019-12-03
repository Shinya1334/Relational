//
//  SignIn.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/02.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase
struct SignIn : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false



    var body: some View {
        VStack {
            TextField("メールアドレスを入力してください", text: $email)
                .padding(.all, 30)

            SecureField("Password", text: $password)
                .padding(.all, 30)

            if (error) {
                Text("ahhh crap")
            }
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
//                    self.lblCaution.text = "☹️\n\(error.localizedDescription)"
                }
                else if let user = user {
                    print(user)
//                    self.lblCaution.text = "😍\n Logged in with : \(user.email!)"
                }
                }}) {
                Text("Sign in")
            }
        }
    }
}
