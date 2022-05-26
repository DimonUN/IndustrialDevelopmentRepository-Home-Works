//
//  Coordinator.swift
//  Navigation
//
//  Created by Дмитрий Никоноров on 24.04.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    var onComplete: ((Factory.ModuleType) -> Void)? { get set }
}
