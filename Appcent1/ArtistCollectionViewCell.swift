//
//  ArtistCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with artist: Artist){
        titleLabel.text = artist.name
        if let imageUrl = URL(string: artist.picture) {
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
    }
    
}
