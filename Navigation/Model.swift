//
//  Model.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 17.04.2022.
//

import Foundation
import UIKit

struct Model {
    struct ViewModel {
        let password: String
    }

    private var notify: Bool = false {
        didSet {
            if notify {
                let info = ["color" : UIColor.systemGreen]
                NotificationCenter.default.post(name: .verificationPassword, object: nil, userInfo: info)
            } else {
                let info = ["color" : UIColor.systemRed]
                NotificationCenter.default.post(name: .verificationPassword, object: nil, userInfo: info)
            }
        }
    }

    private let firstModel = ViewModel(password: "password")
    private func getHash() -> Int {
        let passwordHash = firstModel.password.hashValue
        return passwordHash
    }

    mutating func check(word: Int) {
        let passwordHash = getHash()
        if passwordHash == word {
            notify = true
        } else {
            notify = false
        }
    }
}

extension Notification.Name {
    static var verificationPassword: Notification.Name {
        return .init(rawValue: "Verification Password")
    }
}
