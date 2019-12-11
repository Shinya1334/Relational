//
//  HomeViewModel.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/12/11.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject  {
    // MARK: Private
    private let authProvider: AuthProviderProtocol
    
    // MARK: Output
    @Published private(set) var canSignIn: Bool = true
    
    // MARK: Action
    func SignOut() -> AnyPublisher<Void, Error> {
        canSignIn = false
        
        return authProvider.SignOut()
            .receive(on: RunLoop.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                self?.canSignIn = true
            })
            .eraseToAnyPublisher()
    }
    
    init(authProvider: AuthProviderProtocol = AuthProvider()) {
        self.authProvider = authProvider
    }
}
