//
//  CharacterDetailImageCell.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class CharacterDetailImageCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    func setup(field: DetailField) {
        guard case let DetailField.image(imageUrl) = field else { return }
        let filter = ScaledToSizeCircleFilter(size: CGSize(width: 300, height: 300))
        characterImageView.af_setImage(withURL: imageUrl, placeholderImage: nil, filter: filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion: nil)
        
    }
    
}
