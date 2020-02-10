////
////  SignInViewModel.swift
////  Relational
////
////  Created by Funatsuki Kaito on 2019/12/11.
////  Copyright © 2019 shinya yoshitaka. All rights reserved.
////
//
//import Foundation
//import Combine
//import Firebase
//
//final class SignInViewModel: ObservableObject {
//    // MARK: Private
//    private let authProvider: AuthProviderProtocol
//    @Published private var isBusy: Bool = false
//
//    // MARK: Input
//    @Published var email: String = ""
//    @Published var password: String = ""
//
//    // MARK: Output
//    @Published private(set) var canSignIn: Bool = false
//    @Published private(set) var validationText: String = ""
//    @Published private(set) var result: String = "failed"
//
//
//    // MARK: Action
//    func SignIn() -> ( String)
//    {
//        result = ""
//        isBusy = true
//        validationText = ""
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//                        if let error = error {
//                            print(error.localizedDescription)
//                            self.validationText = "Incorrect ID or password"
//                        }
//                        else if user != nil {
//                            self.validationText = "success"
//                            self.result="success"
//                        }
//        }
//        return self.result
////        return authProvider.SignIn(userId: userId, password: password)
////            .receive(on: RunLoop.main)
////            .handleEvents(receiveCompletion: { [weak self] completion in
////                switch completion {
////                case .finished:
////                    self?.validationText = ""
////                case .failure:
////                    self?.validationText = "Incorrect ID or password"
////                }
////
////                self?.isBusy = false
////            })
////            .eraseToAnyPublisher()
//    }
//
//    init(authProvider: AuthProviderProtocol = AuthProvider()) {
//        self.authProvider = authProvider
//
//        _ = Publishers
//            .CombineLatest3($email, $password, $isBusy)
//            .map { (email, password, isBusy) in
//                return !(email.isEmpty || password.isEmpty || isBusy)
//            }
//            .receive(on: RunLoop.main)
//            .assign(to: \.canSignIn, on: self)
//    }
//}
