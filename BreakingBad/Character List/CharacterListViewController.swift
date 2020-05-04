//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import UIKit
import Signals

class CharacterListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var layoutSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyCharactersLabel: UILabel!
    
    let viewModel = CharacterListViewModel()
    
    private let gridLayout = UICollectionViewFlowLayout()
    private let fullscreenLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        fullscreenLayout.scrollDirection = .horizontal
        fullscreenLayout.minimumLineSpacing = 0
        fullscreenLayout.minimumInteritemSpacing = 0
        
        emptyCharactersLabel.isHidden = true
        
        updateLayout()
        
        viewModel.onCharactersLoading.subscribe(with: self) { [weak self] progress in
            self?.updateProgress(progress)
        }
        
        updateProgress(viewModel.loadingProgress)
        
        viewModel.onCharactersUpdated.subscribe(with: self) { [weak self] empty in
            if !empty {
                self?.collectionView.isHidden = false
                self?.emptyCharactersLabel.isHidden = true
            }
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        viewModel.onCharactersEmpty.subscribe(with: self) { [weak self] message in
            self?.emptyCharactersLabel.text = message
            self?.emptyCharactersLabel.isHidden = false
            self?.collectionView.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fullscreenLayout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        gridLayout.itemSize = CGSize(width: collectionView.frame.width, height: 200)
    }
    
    @IBAction private func filtersTapped() {
        viewModel.filtersTapped()
    }
    
    @IBAction private func updateLayout() {
        if layoutSegmentedControl.selectedSegmentIndex == 0 {
            collectionView.isPagingEnabled = true
            collectionView.showsVerticalScrollIndicator = false
            fullscreenLayout.invalidateLayout()
            collectionView.setCollectionViewLayout(fullscreenLayout, animated: true)
        } else {
            collectionView.isPagingEnabled = false
            gridLayout.invalidateLayout()
            collectionView.showsVerticalScrollIndicator = true
            collectionView.setCollectionViewLayout(gridLayout, animated: true)
        }
    }
    
    private func updateProgress(_ progress:LoadingProgress?) {
        guard let progress = progress else { return }
        switch progress {
        case .started:
            self.loading.isHidden = false
            self.loading.startAnimating()
            self.collectionView.isHidden = true
        case .finished:
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.collectionView.isHidden = false
        case .failed(let message):
            self.loading.isHidden = true
            self.showError(message)
        }
    }
    
    private func showError(_ message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numCharacters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        if let viewModel = viewModel.character(at: indexPath.row) {
            cell.setup(viewModel: viewModel)
        }
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
    
}

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
}

