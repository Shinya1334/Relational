//
//  SignChangeView.swift
//  Relational
//
//  Created by 大城祐介 on 2020/01/16.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Foundation
import KeyboardObserving
import Firebase

struct SignChangeView: View {
    var verified = Firebase.Auth.auth().currentUser?.isEmailVerified
    @EnvironmentObject var session: Session
    @ObservedObject private var vm = SignInViewModel()
    @State private var willChange = false
    @State private var decideChange = false
    @State private var email: String = ""
    @State private var oldpassword: String = ""
    @State private var newPassword: String = ""
    @State private var olddispname: String = ""
    @State private var newdispname: String = ""
    
    
    var body: some View {
//        TabView {
//            Text("The First Tab")
//                .tabItem {
//                    Image(systemName: "1.square.fill")
//                    Text("First")
//                }
//            Text("Another Tab")
//                .tabItem {
//                    Image(systemName: "2.square.fill")
//                    Text("Second")
//                }
//            Text("The Last Tab")
//                .tabItem {
//                    Image(systemName: "3.square.fill")
//                    Text("Third")
//                }
//        }
//        .font(.headline)
        NavigationView{
            VStack{
//                HStack{
//                    
//                }
//                Text(vm.email)
//                SecureField("Password", text: $vm.password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                if (!vm.validationText.isEmpty) {
//                    Text(vm.validationText)
//                        .font(.caption)
//                        .foregroundColor(Color.red)
//                }
                
                willChangeButton(isChange: $willChange)
                CapsuleText(text: "カピバラ")
                Text(willChange ? "ほげ" : "ふが")
                
//                if ((user) != nil) {
//                    self.flag = true
//                  } else {
//                    self.flag = false
//                  }
                
                Button(action: {
//                    let user = Auth.auth().currentUser;
                    self.decideChange.toggle()
                })
                {
                    Text("変更を反映")
                }
                NavigationLink(destination: LandmarkDetail(), isActive: $decideChange ) { EmptyView() }
            }
        }
    }
}

struct SignChangeView_Previews: PreviewProvider {
    static var previews: some View {
        SignChangeView()
    }
}

struct willChangeButton: View {
    @Binding var isChange: Bool    // 親Viewの値を参照する
    
    var body: some View {
        Button(action: {
            self.isChange.toggle()     // クリックでisPowerOnの値を反転
        }) {
            Image(systemName: "pencil")  // 編集ボタンの画像
        }
    }
}

struct TabView<SelectionValue, Content> where
SelectionValue : Hashable, Content : View{
}

struct CapsuleText: View {
    var text: String
 
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .clipShape(Rectangle())
    }
}
//Toggle("", isOn: $willChange)
//               .frame(width: 0)
