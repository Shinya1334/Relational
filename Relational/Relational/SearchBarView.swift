//
//  SearchBarView.swift
//  Relational
//
//  Created by 安座間一喜 on 2019/12/19.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {

    let array = ["Chat","Soccer","Ie","知能情報コース"]

    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            List{
                TextField("Type your search",text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self){searchText in
                    Text(searchText)
                }
            }
            .navigationBarTitle(Text("検索"))
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
