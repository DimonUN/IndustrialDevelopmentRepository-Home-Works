//
//  CustomViews.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 16.04.2022.
//

import Foundation
import UIKit

class RegularButton: UIButton {
    var touchUpInside: (() -> Void)?
    var touchDown: (() -> Void)?

    init(setTitle title: String, for titleState: UIControl.State) {
        super.init(frame: .zero)
        self.setTitle(title, for: titleState)
        self.toAutoLayout()
        self.addTarget(self, action: #selector(buttonRealesed), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonRealesed(_ sender: UIButton) {
        touchUpInside?()
    }

    @objc private func buttonPressed(_sender: UIButton) {
        touchDown?()
    }
}

class RegularTextField: UITextField {
    init() {
        super.init(frame: .zero)
        self.toAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getPassword() -> Int {
        guard let passwordHash = self.text?.hashValue else { return 0 }
        return passwordHash
    }
}
