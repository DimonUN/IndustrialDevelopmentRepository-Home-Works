//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 10.06.2022.
//

import Foundation

protocol LoginViewConrollerDelegate: AnyObject {
    func verify(login: Int?, password: Int?) throws -> Bool
}

class LoginInspector: LoginViewConrollerDelegate {
    let data = Cheker.shared.getData()

    func verify(login: Int?, password: Int?) throws -> Bool {
        if data.0 == login, data.1 == password {
            return true
        } else if login == 0, password == 0 {
            throw LoginError.emptyData
        } else if login == 0 {
            throw LoginError.emptyLogin
        } else if password == 0 {
            throw LoginError.emptyPassword
        } else {
            throw LoginError.wrongLonigOrPassword
        }
    }
}

protocol LoginFactory {
    func createInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func createInspector() -> LoginInspector {
        return LoginInspector()
    }
}
