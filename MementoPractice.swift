// MementoPractice.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

struct User {
    var name: String
    var surname: String
}

class StateUserMemento {
    var user: User

    init(user: User) {
        self.user = user
    }
}
