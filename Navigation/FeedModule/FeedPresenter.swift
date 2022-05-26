//
//  Presenter.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 25.04.2022.
//

import UIKit

protocol ModuleInput {
    var labelName: String? { get set }
}

protocol ViewOutput {
    var onSelectViewOutput: ((Factory.ModuleType) -> Void)? { get set }
    var onSelectOutputData: ((Int) -> Void)? { get set }
}

protocol Presenter {
    var coordinator: Coordinator? { get set }
    var viewInput: ViewInput? { get set }
    var data: String? { get set }
}

class FeedPresenter: Presenter, ModuleInput, ViewOutput {

    var coordinator: Coordinator?
    var data: String? {
        didSet {
            labelName = data
        }
    }

    weak var viewInput: ViewInput?
    var model = Model()


    //MARK: -Output
    lazy var onSelectViewOutput: ((Factory.ModuleType) -> Void)? = { type in
        self.coordinator?.onComplete?(type)
    }

    lazy var onSelectOutputData: ((Int) -> Void)? = { value in
        self.model.check(word: value)
    }

    //MARK: -Input
    var labelName: String? {
        didSet {
            viewInput?.configure(text: labelName ?? "")
        }
    }
}
