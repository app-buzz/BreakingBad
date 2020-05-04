//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Guy Watson on 04/05/2020.
//  Copyright © 2020 Guy Watson. All rights reserved.
//

import UIKit
import AlamofireImage

class CharacterCell: UICollectionViewCell, ReusableCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func setup(viewModel: CharacterViewModel) {
        nameLabel.text = viewModel.name
        //using AspectScaledToFillSizeCircleFilter cuts off some of the heads :(
        let filter = ScaledToSizeCircleFilter(size: CGSize(width: 300, height: 300))
        imageView.af_setImage(withURL: viewModel.imageUrl, placeholderImage: nil, filter: filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false, completion: nil)
    }
    
}
