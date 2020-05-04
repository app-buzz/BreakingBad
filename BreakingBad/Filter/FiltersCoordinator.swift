//
//  FiltersCoordinator.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import Signals

class FiltersCoordinator: BaseCoordinator {
    
    var selectedSeasons: [Int]
    
    let onTapApply = Signal<[Int]>()
    
    init(selectedSeasons: [Int]) {
        self.selectedSeasons = selectedSeasons
    }
    
    override func start() {
        let filtersViewController = FiltersViewController.instantiate()
        let viewModel = FiltersViewModel(selectedSeasons: selectedSeasons)
        viewModel.onTapApply.subscribe(with: self) { [weak self] selectedSeasons in
            guard let `self` = self else { return }
            self.selectedSeasons = selectedSeasons
            self.parentCoordinator?.didFinish(coordinator: self)
            self.navigationController.dismiss(animated: true, completion: nil)
            self.onTapApply.fire(selectedSeasons)
        }
        viewModel.onTapCancel.subscribe(with: self) { [weak self] in
            guard let `self` = self else { return }
            self.parentCoordinator?.didFinish(coordinator: self)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        filtersViewController.viewModel = viewModel
        navigationController.viewControllers = [filtersViewController]
    }
    
    
    
}
