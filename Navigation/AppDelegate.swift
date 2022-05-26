import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        window = UIWindow()
//        
//        let tabBarController = UITabBarController()
//        let model = Model()
//
//        let logInVC = LogInViewController()
//        logInVC.tabBarItem = UITabBarItem(title: "Profile", image: .init(systemName: "person.fill"), tag: 0)
//        
//        let feedVC = FeedViewController(model: model)
//        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: .init(systemName: "house.fill"), tag: 1)
//        
//        let navigationAppearance = UINavigationBarAppearance()
//        navigationAppearance.backgroundColor = .systemGray6
//        
//        let profileNavigationController = UINavigationController(rootViewController: logInVC)
//        profileNavigationController.navigationBar.scrollEdgeAppearance = navigationAppearance
//        
//        
//        let feedNavigationController =
//            UINavigationController(rootViewController: feedVC)
//        feedNavigationController.navigationBar.scrollEdgeAppearance = navigationAppearance
//    
//        tabBarController.tabBar.backgroundColor = .systemGray6
//        tabBarController.tabBar.unselectedItemTintColor = .systemGray
//        tabBarController.tabBar.tintColor = .systemBlue
//        
//        tabBarController.setViewControllers([feedNavigationController, profileNavigationController ], animated: true)
//        tabBarController.selectedIndex = 0
//        
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

