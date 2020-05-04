//
//  CharacterListCoordinator.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation

class CharacterListCoordinator: BaseCoordinator {
    
    private var filtersCoordinator: FiltersCoordinator?
    
    private var characterListViewController: CharacterListViewController!
    
    override func start() {
        characterListViewController = CharacterListViewController.instantiate()
        characterListViewController.viewModel.onTapFilters.subscribe(with: self) { [weak self] selectedSeasons in
            self?.showFilters(selectedSeasons: selectedSeasons)
        }
        characterListViewController.viewModel.onTapCharacter.subscribe(with: self) { [weak self] character in
            self?.showCharacterDetails(character)
        }
        self.navigationController.viewControllers = [characterListViewController]
    }
    
    func showFilters(selectedSeasons: [Int]) {
        let filtersCoordinator = FiltersCoordinator(selectedSeasons: selectedSeasons)
        filtersCoordinator.onTapApply.subscribe(with: self) { [weak self] selectedSeasons in
            guard let `self` = self else { return }
            self.characterListViewController.viewModel.filteredSeasons = selectedSeasons
        }
        start(coordinator: filtersCoordinator)
        self.filtersCoordinator = filtersCoordinator
        self.navigationController.present(filtersCoordinator.navigationController, animated: true, completion: nil)
    }
    
    func showCharacterDetails(_ character: BreakingBadCharacter) {
        let characterDetailsViewController = CharacterDetailsViewController.instantiate()
        characterDetailsViewController.viewModel = CharacterDetailsViewModel(character: character)
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
    
}
