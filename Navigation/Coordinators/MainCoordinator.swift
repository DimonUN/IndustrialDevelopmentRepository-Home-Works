//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 24.04.2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let factory = Factory()

    var profileNavigationController: UINavigationController
    var feedNavigationController: UINavigationController
    var tabBarController: UITabBarController

    init() {
        tabBarController = UITabBarController()
        profileNavigationController = UINavigationController()
        feedNavigationController = UINavigationController()
    }

    lazy var onComplete: ((Factory.ModuleType) -> Void)? = { type in
        self.startChildCoordinator(controllerType: type)
        
    }
    
    func start() {
        let feedController = configureFeedModule()
        let profileController = configureProfileModule()

        feedNavigationController.pushViewController(feedController, animated: false)
        profileNavigationController.pushViewController(profileController, animated: false)
        configureMain()
    }

    private func configureFeedModule() -> UIViewController {

        //  Создаем презентер
        var presenter = factory.createPresenter(type: .feed)
        presenter.coordinator = self

        //  Создаем контроллер.
        let feedViewController = factory.createViewController(presenter: presenter, controllerType: .feed)

        //  Даем презентеру ссылку на контроллер
        presenter.viewInput = feedViewController as? ViewInput

        //  Настраиваем вход в котроллер
        presenter.data = factory.createDataModel().labelTitle
        return feedViewController
    }

    private func configureProfileModule() -> UIViewController {
        let presenter = factory.createPresenter(type: .profile)
        let profileController = factory.createViewController(presenter: presenter, controllerType: .profile)
        return profileController
    }

    private func configureMain() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemGray6

        profileNavigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        feedNavigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        tabBarController.tabBar.tintColor = .systemBlue

        tabBarController.setViewControllers([feedNavigationController, profileNavigationController ], animated: false)
        tabBarController.selectedIndex = 0
    }

    private func startChildCoordinator(controllerType: Factory.ModuleType) {
        let coordinator = ChildCoordinator(
            navigationController: feedNavigationController,
            parentCoordinator: self,
            input: nil,
            controllerType: controllerType
        )

        coordinator.start()
    }
}
