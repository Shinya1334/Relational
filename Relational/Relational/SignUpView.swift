//
//  LoginView.swift
//  Relational
//
//  Created by 安座間一喜 on 2019/11/26.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Foundation

struct SignUpView: View {
     // 1.
       @State var maill = ""
       @State var password = ""
       @State var isShown = false
    
       var body: some View {
           VStack {
            Text("メールアドレスを入力して下さい")
                .font(.system(size: 25))
            
            TextField(" Enter some text", text: $maill)
                .border(Color.black)
            
            Text("\(maill)")
            
            Text("パスワードを入力して下さい")
            
            TextField(" Enter some text", text: $password)
                .border(Color.black)
            
            Button(action: {
                self.isShown = true
            }) {
                Text("Show ActionSheet")
            }
            .actionSheet(isPresented: $isShown, content: {
                            ActionSheet(
                                title: Text("Title"),
                                message: Text("Message"),
                                buttons: [
                                    .default(Text("Default")),
                              .destructive(Text("Destructive")),
                              .cancel()]
                        )
                    })
                }
            }
           }

           //.padding()
           //.font(.title)



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
