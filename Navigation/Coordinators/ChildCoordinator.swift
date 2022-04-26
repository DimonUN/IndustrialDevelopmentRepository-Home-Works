//
//  ChildCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 24.04.2022.
//

import UIKit

class ChildCoordinator: Coordinator {
    lazy var onComplete: ((Factory.ModuleType) -> Void)? = { type in
        self.startNextModule(type: type)
    }

    struct Input {
        var data: String
    }

    private let factory = Factory()
    private var input: Input?
    private var controllerType: Factory.ModuleType
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    unowned let parentCoordinator: MainCoordinator

    init(navigationController: UINavigationController, parentCoordinator: MainCoordinator, input: Input?, controllerType: Factory.ModuleType) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.input = input
        self.controllerType = controllerType
    }

    func start() {
        var presenter = factory.createPresenter(type: .post)
        presenter.coordinator = self
        let nextController = factory.createViewController(presenter: presenter, controllerType: .post)
        presenter.viewInput = nextController as? ViewInput
        presenter.data = "Экран Post Model"
        navigationController.pushViewController(nextController, animated: true)
    }

    private func startNextModule(type: Factory.ModuleType) {
        let nextPresenter = NextPresenter()
        let nextController = factory.createViewController(presenter: nextPresenter, controllerType: .next)
        navigationController.pushViewController(nextController, animated: true)
    }
}
