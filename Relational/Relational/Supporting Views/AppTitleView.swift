//
//  AppTitleView.swift
//  Relational
//
//  Created by shinya yoshitaka on 2020/02/09.
//  Copyright © 2020 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct AppTitleView: View {
    
    var Title: String
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                   
                
                
                Text(Title).font(.system(size: 24)).fontWeight(.medium).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            
                
            }
        }.padding(.top, 30).padding(.leading, 10).background(Color.init(red: 0.9, green: 0.9, blue: 0.9)).shadow(radius:21)
    }
}
struct AppTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AppTitleView(Title: "Example")
    }
}
