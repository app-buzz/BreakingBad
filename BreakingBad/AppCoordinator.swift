//
//  AppCoordinator.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {

    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        self.window.makeKeyAndVisible()
        self.showCharacterList()
    }
    
    private func showCharacterList() {
        self.removeChildCoordinators()
        
        let coordinator = CharacterListCoordinator()
        self.start(coordinator: coordinator)
        window.rootViewController = coordinator.navigationController
    }
}
