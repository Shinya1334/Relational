//
//  User.swift
//  Relational
//
//  Created by Funatsuki Kaito on 2019/11/21.
//  Copyright © 2019 shinya yoshitaka. All rights reserved.
//

import SwiftUI

class User {
    
    let uid: String
    let email: String?
    let displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
