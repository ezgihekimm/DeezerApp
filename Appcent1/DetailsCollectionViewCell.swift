//
//  DetailsCollectionViewCell.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import UIKit
import CoreData

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var heartImage: UIImageView!
    
    var songID: Int = 0
    
    let entityName = "LikedSong"
    var entity: NSEntityDescription!
    var managedContext: NSManagedObjectContext!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access app delegate")
        }
        // Initialize the Core Data managed object context
        managedContext = appDelegate.persistentContainer.viewContext
        
        // Initialize the Core Data entity
        entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        // Fetch the saved liked songs and update the heart icon accordingly
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let songs = result as? [NSManagedObject] {
                for song in songs {
                    if let id = song.value(forKey: "id") as? Int, id == songID {
                        heartImage.image = UIImage(named: "fullHeart")
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    var playButtonAction: (() -> Void)?
    
    // Format the song duration in minutes and seconds
    func formattedTime(duration: Int) -> String {
        let minutes = duration / 60
        let seconds = duration % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        return formattedTime
    }
    
    // Configure the cell with the given song
    func configure(with song: Song){
        titleLabel.text = song.title
        timeLabel.text = formattedTime(duration: song.duration)
        heartImage.image = UIImage(named: "emptyHeart")
        songID = song.id
        if let imageUrl = URL(string: song.cover) {
               songImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
           }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartTapped(_:)))
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(tapGesture)
        
        // Fetch the saved liked songs and update the heart icon accordingly
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let songs = result as? [NSManagedObject] {
                for song in songs {
                    if let id = song.value(forKey: "id") as? Int, id == songID {
                        heartImage.image = UIImage(named: "fullHeart")
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    @IBAction func playButtonTapped(_ sender: Any) {
        playButtonAction?()
    }
    
    // Handle the tap on the heart icon to add or remove the song from the liked songs
    @objc func heartTapped(_ sender: UITapGestureRecognizer) {
        if heartImage.image == UIImage(named: "emptyHeart") {
            heartImage.image = UIImage(named: "fullHeart")
            let likedSong = NSManagedObject(entity: entity, insertInto: managedContext)
            likedSong.setValue(songID, forKeyPath: "id")
            print("Liked Song ID: \(likedSong.value(forKey: "id") ?? "")")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } else {
            heartImage.image = UIImage(named: "emptyHeart")
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %d", songID)
            do {
                let result = try managedContext.fetch(fetchRequest)
                if let songs = result as? [NSManagedObject] {
                    for song in songs {
                        managedContext.delete(song)
                    }
                    try managedContext.save()
                }
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }

    }
