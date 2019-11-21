//
//  CircleImage.swift
//  Relational
//
//  Created by shinya yoshitaka on 2019/11/14.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//


import SwiftUI


struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)
    }
}
struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
