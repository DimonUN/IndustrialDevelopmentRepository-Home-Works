//
//  Factory.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 26.04.2022.
//

import UIKit

class Factory {

    enum ModuleType {
        case feed, post, next
        case profile
    }

    func createPresenter(type: ModuleType) -> Presenter {
        
        switch type {
        case .feed:
            return FeedPresenter()
        case .post:
            return PostPresenter()
        case .next:
            return NextPresenter()
        case .profile:
            return LoginPresenter()
        }
    }

    func createDataModel() -> DataModel {
        return DataModel()
    }
    
    func createViewController(presenter: Presenter, controllerType: ModuleType) -> UIViewController {

        switch controllerType {
        case .feed:
            let feedViewController = FeedViewController(output: presenter as! ViewOutput)
            feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: .init(systemName: "house.fill"), tag: 1)
            return feedViewController

        case .post:
            let postViewController = PostViewController(output: presenter as! ViewOutput)
            return postViewController

        case .next:
            let nextViewController = NextViewController()
            return nextViewController
            
        case .profile:
            let loginViewController = LogInViewController()
            loginViewController.tabBarItem = UITabBarItem(title: "Profile", image: .init(systemName: "person.fill"), tag: 0)
            return loginViewController
        }
    }
}
