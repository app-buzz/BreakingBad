//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import Signals

enum LoadingProgress {
    case started
    case finished
    case failed(message:String)
}

class CharacterListViewModel: BreakingBadServiceInjected {
    
    private(set) var loadingProgress:LoadingProgress? {
        didSet {
            guard let loadingProgress = loadingProgress else { return }
            onCharactersLoading.fire(loadingProgress)
        }
    }
    
    let onTapFilters = Signal<[Int]>()
    let onTapCharacter = Signal<BreakingBadCharacter>()
    
    let onCharactersLoading = Signal<LoadingProgress>()
    
    private var allCharacters:[BreakingBadCharacter] = []
    
    private var characters:[CharacterViewModel] = []
    {
        didSet {
            onCharactersUpdated.fire(characters.count == 0)
        }
    }
    
    let onCharactersUpdated = Signal<Bool>()
    
    let onCharactersEmpty = Signal<String>()
    
    var searchText:String = "" {
        didSet {
            filterCharacters()
        }
    }
    
    var filteredSeasons:[Int] {
        didSet {
            filterCharacters()
        }
    }
    
    init() {
        filteredSeasons = Array(0..<FiltersViewModel.numSeasons)
        loadCharacters()
    }
    
    var numCharacters: Int {
        return characters.count
    }
    
    func character(at index:Int) -> CharacterViewModel? {
        guard index > -1 && index < characters.count else { return nil }
        return characters[index]
    }
    
    func filtersTapped() {
        onTapFilters.fire(filteredSeasons)
    }
    
    func didSelectItem(at index:Int) {
        guard let characterViewModel = character(at: index) else { return }
        onTapCharacter.fire(characterViewModel.character)
    }
    
    private func filterCharacters() {
        characters = allCharacters.filter({ character -> Bool in
            if searchText.count > 0 {
                if !character.name.contains(searchText) {
                    return false
                }
            }
            for season in filteredSeasons {
                if character.appearance.contains(season+1) {
                    return true
                }
            }
            return false
        }).map{ CharacterViewModel(character: $0) }
        
        if characters.count == 0 {
            onCharactersEmpty.fire("No characters found")
        }
    }
    
    func loadCharacters() {
        
        loadingProgress = .started
        breakingBadService.request(.getCharacters) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let characters = try response.map([BreakingBadCharacter].self)
                    self?.allCharacters = characters
                    self?.filterCharacters()
                    self?.loadingProgress = .finished
                } catch {
                    print(error)
                    self?.loadingProgress = .failed(message: error.localizedDescription)
                }
            case .failure(let error):
                self?.loadingProgress = .failed(message: error.localizedDescription)
            }
        }
    }
    
}
