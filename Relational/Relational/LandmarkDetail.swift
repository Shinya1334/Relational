//
//  LandmarkDetail.swift
//  Relational
//
//  Created by shinya yoshitaka on 2019/11/14.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
//app_store_id:974927148
struct LandmarkDetail: View {
    //部屋の検索先を変更する必要あり.
    @State var showMenu = false
    var body: some View {
        let drag = DragGesture()
            .onEnded{
                if $0.translation.width < -100{
                    withAnimation{
                        self.showMenu = false
                    }
                    
                }
        }
        return NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .leading)
                {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu{
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
            .gesture(drag)
            }
            .navigationBarTitle("ホーム", displayMode: .inline)
        .navigationBarItems(leading: (
            Button(action: {
                withAnimation{
                    self.showMenu.toggle()
                }
            })
            {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
        ))
        }
    }
}
struct MainView: View {
    @Binding var showMenu: Bool
    var body: some View{
        Button(action:{
            withAnimation{
                //フラグを画面遷移に変更する必要あり
                self.showMenu = true
            }
        }){
            Text("部屋の検索")
        }
    }
}

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        LandmarkDetail()
    }
}
