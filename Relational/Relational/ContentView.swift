//
//  ContentView.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/11.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI
import Firebase

struct CotentView: View {
    @EnvironmentObject var session: Session

    var body: some View {
        VStack {
            if (Auth.auth().currentUser != nil) {
                LandmarkDetail()
                    .environmentObject(self.session)
            } else {
                SignInView()
                    .environmentObject(self.session)
            }
        }
    }
}

struct CotentView_Previews: PreviewProvider {
    static var previews: some View {
        CotentView()
            .environmentObject(Session())
    }
}
