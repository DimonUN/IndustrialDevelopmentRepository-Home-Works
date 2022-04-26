//
//  PostPresenter.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 26.04.2022.
//

import UIKit

final class PostPresenter: Presenter, ModuleInput, ViewOutput {
    var data: String? {
        didSet {
            labelName = data
        }
    }

    weak var viewInput: ViewInput?
    var coordinator: Coordinator?

    //MARK: -Output
    lazy var onSelectViewOutput: ((Factory.ModuleType) -> Void)? = { type in
        self.coordinator?.onComplete?(type)
    }

    lazy var onSelectOutputData: ((Int) -> Void)? = { value in
    }

    //MARK: -Input
    var labelName: String? {
        didSet {
            viewInput?.configure(text: labelName ?? "")
        }
    }


}

