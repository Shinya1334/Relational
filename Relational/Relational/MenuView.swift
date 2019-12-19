//
//  MenuView.swift
//  Relational
//
//  Created by shinya yoshitaka on 2019/11/21.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "turtlerock")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                NavigationLink(destination: HomeView()) {
                    Text("ホーム")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 100)
            HStack{
                Image(systemName: "icybay")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                NavigationLink(destination: HomeView()) {
                    Text("プロフィール")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            HStack{
                Image(systemName: "lakemcdonld")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                NavigationLink(destination: HomeView()) {
                    Text("最近使用した部屋")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
        HStack{
            Image(systemName: "umbagog")
                .foregroundColor(.gray)
                .imageScale(.large)
            NavigationLink(destination: HomeView()) {
                Text("setting")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
        .padding(.top, 30)
        Spacer()
    }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
