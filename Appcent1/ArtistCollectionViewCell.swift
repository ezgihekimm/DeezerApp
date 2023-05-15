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
    
    // Configure the cell with a given artist object
    func configure(with artist: Artist){
        titleLabel.text = artist.name
        if let imageUrl = URL(string: artist.picture) {
            
            // Set the category image view to display the image from the URL using the SDWebImage library
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
    }
    
}
