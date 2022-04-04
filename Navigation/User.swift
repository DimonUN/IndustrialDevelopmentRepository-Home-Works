//
//  User.swift.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 02.04.2022.
//

import Foundation
import UIKit

//MARK: -Выполнение условий ДЗ

class User {
    var name: String
    var avatarImage: UIImage
    var status: String
    
    init(name: String, avatarImage: UIImage, status: String) {
        self.name = name
        self.avatarImage = avatarImage
        self.status = status
    }
}

protocol UserService {
    func nameVerification(userName: String) -> User
}


class CurrentUserService: UserService {
    let user = User(name: "Hipster Cat", avatarImage: UIImage(named: "cat") ?? UIImage(named: "logo")!, status: "My life, my rule")
    
    func nameVerification(userName: String) -> User {
        guard user.name == userName else {
            let unknownUser = User(name: "Unknown name", avatarImage: UIImage(named: "logo")!, status: "Unknown status")
            return unknownUser
        }
        return user
    }
}

class TestUserService: UserService {
    let user = User(name: "test", avatarImage: UIImage(named: "test")!, status: "test")
    
    func nameVerification(userName: String) -> User {
        guard user.name == userName else {
            let unknownUser = User(name: "Unknown name", avatarImage: UIImage(named: "logo")!, status: "Unknown status")
            return unknownUser
        }
        return user
    }
    
    
}
