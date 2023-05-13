//
//  ImageCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistImage: UIImageView!
    
    var artistCover: String = "" {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func updateUI() {
        if let url = URL(string: artistCover) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.artistImage.image = image
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "unknown error")")
                }
            }.resume()
        }
        print(artistCover)

    }

}
