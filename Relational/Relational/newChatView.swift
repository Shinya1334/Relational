////
////  newChatView.swift
////  Relational
////
////  Created by shinya yoshitaka on 2020/02/09.
////  Copyright © 2020 shinya yoshitaka. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//import SDWebImageSwiftUI
//
//struct newChatView : View {
//
//    @ObservedObject var datas = getAllUsers()
//    @Binding var name : String
//    @Binding var uid : String
//    @Binding var pic : String
//    @Binding var show : Bool
//    @Binding var chat : Bool
//
//
//    var body : some View{
//
//        VStack(alignment: .leading){
//
//                if self.datas.users.count == 0{
//
//                    Indicator()
//                }
//                else{
//
//                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))
//
//                    ScrollView(.vertical, showsIndicators: false) {
//
//                        VStack(spacing: 12){
//
//                            ForEach(datas.users){i in
//
//                                Button(action: {
//
//                                    self.uid = i.id
//                                    self.name = i.name
//                                    self.pic = i.pic
//                                    self.show.toggle()
//                                    self.chat.toggle()
//
//
//                                }) {
//
//                                    UserCellView(url: i.pic, name: i.name, about: i.about)
//                                }
//
//
//                            }
//
//                        }
//
//                    }
//              }
//        }.padding()
//    }
//}
