//
//  DetailsCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var heartImage: UIImageView!
    
    var playButtonAction: (() -> Void)?
    
    func formattedTime(duration: Int) -> String {
        let minutes = duration / 60
        let seconds = duration % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        return formattedTime
    }
    @IBAction func playButtonTapped(_ sender: Any) {
        playButtonAction?()
    }
    @objc func heartTapped(_ sender: UITapGestureRecognizer) {
        if heartImage.image == UIImage(named: "emptyHeart") {
            heartImage.image = UIImage(named: "fullHeart")
        } else {
            heartImage.image = UIImage(named: "emptyHeart")
        }
    }

    func configure(with song: Song){
        titleLabel.text = song.title
        timeLabel.text = formattedTime(duration: song.duration)
        heartImage.image = UIImage(named: "emptyHeart")
        
        if let imageUrl = URL(string: song.cover) {
               songImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartTapped(_:)))
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(tapGesture)

    }
    
}
