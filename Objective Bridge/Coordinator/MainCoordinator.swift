//
//  MainCoordinator.swift
//  Objective Bridge
//
//  Created by Anderson Sprenger on 25/03/22.
//

import Foundation

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesTableViewController()
        vc.coordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(vc, animated: false)
    }
}
