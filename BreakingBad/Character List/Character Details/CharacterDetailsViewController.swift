//
//  CharacterDetailsViewController.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CharacterDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.title = viewModel.title
    }
    
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numFields
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let field = viewModel.field(at: indexPath.row) else { return UITableViewCell() }
        switch field {
        case .text:
           let cell: CharacterDetailTextCell = tableView.dequeueReusableCell(for: indexPath)
           cell.setup(field: field)
           return cell
        case .image:
            let cell: CharacterDetailImageCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(field: field)
            return cell
        }
    }
}

extension CharacterDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let field = viewModel.field(at: indexPath.row) else { return 0 }
        switch field {
        case .text:
            return UITableView.automaticDimension
        case .image:
            return 300
        }
        
    }
    
}
