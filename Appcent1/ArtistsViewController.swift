//
//  ArtistsViewController.swift
//  MusicApp1
//
//  Created by Ezgi Hekim on 12.05.2023.
//

import UIKit

class ArtistsViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryID: Int = 0
    var categoryName: String = ""
    var artists = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryName
        callAPI()
            
        }
    func callAPI() {
        guard let url = URL(string: "https://api.deezer.com/genre/\(categoryID)/artists") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let temps = json["data"] as? [[String: Any]] {
                    for temp in temps {
                        if let id = temp["id"] as? Int,
                           let name = temp["name"] as? String,
                           let picture = temp["picture"] as? String {
                            let artistInfo = Artist(id: id, name: name, picture: picture)
                            self.artists.append(artistInfo)
                            print(artistInfo)
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
extension ArtistsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistCollectionViewCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let temp = artists[indexPath.item]
                cell.configure(with: temp)
                return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artists.count
    }
}

extension ArtistsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToAlbum", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAlbum" {
            if let destinationVC = segue.destination as? AlbumViewController,
               let indexPath = sender as? IndexPath {
                destinationVC.artistID = artists[indexPath.row].id
                destinationVC.artistName = artists[indexPath.row].name
                destinationVC.currentImage = artists[indexPath.row].picture
            }
        }
    }

    
}



