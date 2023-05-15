//
//  CategoryCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Configure the cell with a given category object
    func configure(with category: Category){
        titleLabel.text = category.name
        if let imageUrl = URL(string: category.picture) {
            
            // Set the category image view to display the image from the URL using the SDWebImage library
               imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
    }
    
    
}
