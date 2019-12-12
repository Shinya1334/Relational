//
//  File.swift
//  Relational
//
//  Created by 大城祐介 on 2019/12/05.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//
import SwiftUI
import Firebase
import Foundation
struct SignChange : View {

    @State var email: String = ""
    @State var displayname: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var flag = false
    
    var body: some View {
    NavigationView{
            VStack {
                TextField()
                SecureField()
                if (error) {
                    Text("ahhh crap")
                }
                
                Button(action: {}
        }
    }
                 
    struct SignChange_Previews: PreviewProvider {
        static var previews: some View {
            SignChange()
        }
    }
}
}
