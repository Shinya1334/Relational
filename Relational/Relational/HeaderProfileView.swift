//
//  HeaderProfileView.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/19.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct Header: View {
    var body: some View {
        Rectangle()
            .frame(width: 500)
    }
}

struct ProfileImage: View {
    var body: some View {
        VStack {
            Image("profile")
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}
