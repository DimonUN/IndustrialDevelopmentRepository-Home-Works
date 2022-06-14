//
//  Checker.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 10.06.2022.
//

import Foundation

final class Cheker {
    static var shared: Cheker { Cheker() }

    let login = "login"
    let password = "password"

    func getData() -> (Int, Int) {
        let data: (Int, Int) = (login.hash, password.hash)
        return data
    }
}
