//
//  AlbumCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // Configure the cell with a given album object
    func configure(with album: Album){
        titleLabel.text = album.title
        dateLabel.text = album.release_date
        if let imageUrl = URL(string: album.cover) {
            // Set the category image view to display the image from the URL using the SDWebImage library
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
    }
}

