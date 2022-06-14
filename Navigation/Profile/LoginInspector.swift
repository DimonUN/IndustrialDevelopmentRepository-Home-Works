//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 10.06.2022.
//

import Foundation

protocol LoginViewConrollerDelegate: AnyObject {
    func verificatoin(lgn: Int?, pswd: Int?) throws -> Bool
}

class LoginInspector: LoginViewConrollerDelegate {
    let data = Cheker.shared.getData()

    func verificatoin(lgn: Int?, pswd: Int?) throws -> Bool {
        if data.0 == lgn, data.1 == pswd {
            return true
        } else if lgn == 0, pswd == 0 {
            throw LoginError.emptyData
        } else if lgn == 0 {
            throw LoginError.emptyLogin
        } else if pswd == 0 {
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
