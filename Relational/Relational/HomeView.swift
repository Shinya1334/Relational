//
//  HomeView.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/11.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: Session
    @ObservedObject private var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("Hello \(self.session.user?.name ?? "")!")
            Button(action: {
                _ = self.vm.SignOut()
                    .sink(receiveCompletion: { err in
                        self.session.user = nil
                        self.session.isSignIn = false
                    }, receiveValue: {})
            }) {
                Text("Sign out")
            }.disabled(!vm.canSignIn)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Session(isSignIn: true, user: User(id: "userId", name: "foobar")))
    }
}
