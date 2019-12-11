//
//  AuthProvider.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/11.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import Foundation
import Combine

final class AuthProvider: AuthProviderProtocol {
    func SignIn(userId: String, password: String) -> Future<User, Error> {
        
        return Future<User, Error> { promise in
            // This closure is unexpectedly called synchronously.
            // Therefore, wrap it with DispatchQueue.global().async
            DispatchQueue.global().async {
                // Intended to network communicate
                Thread.sleep(forTimeInterval: 1.0)
                
                 if userId == "foobar@example.com" && password == "password" {
                     promise(.success(User(id: userId, name: "foobar")))
                 } else {
                     promise(.failure(AuthError.invalidIdOrPassword))
                 }
            }
        }
    }
    
    func SignOut() -> Future<Void, Error> {
        // This closure is unexpectedly called synchronously.
        // Therefore, wrap it with DispatchQueue.global().async
        return Future<Void, Error> { promise in
            DispatchQueue.global().async {
                // Intended to network communicate
                Thread.sleep(forTimeInterval: 1.0)
                
                promise(.success(()))
            }
        }
    }
}
