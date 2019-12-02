//
//  SignIn.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/02.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct SignIn : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: AuthUser

    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        VStack {
            TextField("メールアドレスを入力してください", text: $email)
            SecureField("Password", text: $password)
            if (error) {
                Text("ahhh crap")
            }
            Button(action: signIn) {
                Text("Sign in")
            }
        }
    }
}
