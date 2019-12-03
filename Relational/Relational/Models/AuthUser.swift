////
////  AuthUser.swift
////  Relational
////
////  Created by Funatsuki Kaito on 2019/12/02.
////  Copyright © 2019 shinya yoshitaka. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//import Combine
//
//struct User {
//    var uid: String
//    var email: String?
//    var displayName: String?
//    
//    init(uid: String, email: String?, displayName: String?) {
//        self.uid = uid
//        self.email = email
//        self.displayName = displayName
//    }
//}
//
//class AuthUser : BindableObject {
//var didChange = PassthroughSubject<AuthUser, Never>()
//var isLoggedIn = false { didSet { self.didChange.send(self) }}
//var session: User? { didSet { self.didChange.send(self) }}
//var handle: AuthStateDidChangeListenerHandle?
//
//init(session: User? = nil) {
//    self.session = session
//}
//
//func listen () {
//    handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//        if let user = user {
//            print("Got user \(user)")
//            self.isLoggedIn = true
//            self.session = User(
//                uid: user.uid,
//                displayName: user.displayName,
//                email: user.email,
//                photoURL: user.photoURL
//            )
//        } else {
//            self.isLoggedIn = false
//            self.session = nil
//        }
//    }
//}
//    func signUp(
//        email: String,
//        password: String,
//        handler: @escaping AuthDataResultCallback
//        ) {
//        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
//    }
//
//    func signIn(
//        email: String,
//        password: String,
//        handler: @escaping AuthDataResultCallback
//        ) {
//        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
//    }
//
//    func signOut () -> Bool {
//        do {
//            try Auth.auth().signOut()
//            self.session = nil
//            return true
//        } catch {
//            return false
//        }
//    }
//    func unbind () {
//        if let handle = handle {
//            Auth.auth().removeStateDidChangeListener(handle)
//        }
//    }
//}
