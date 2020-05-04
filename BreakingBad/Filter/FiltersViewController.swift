//
//  FiltersViewController.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FiltersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        for s in viewModel.selectedSeasons {
            tableView.selectRow(at: IndexPath(row: s, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    @IBAction func applyFilters() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            viewModel.selectedSeasons = selectedRows.map { $0.row }
        } else {
            viewModel.selectedSeasons = []
        }
        viewModel.tappedApply()
    }
    
    @IBAction func cancel() {
        viewModel.tappedCancel()
    }
    
}

extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numFilters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FilterCell = tableView.dequeueReusableCell(for: indexPath)
        if let viewModel = viewModel.filter(at: indexPath.row) {
            cell.setup(viewModel: viewModel)
        }
        return cell
        
    }
    
    
}
