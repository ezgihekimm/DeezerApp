//
//  AlbumViewController.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 13.05.2023.
//

import UIKit

class AlbumViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var artistID: Int = 0
    var artistName: String = ""
    var currentImage: String = ""
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = artistName
        callAPI()
    }
    
    func callAPI() {
        guard let url = URL(string: "https://api.deezer.com/artist/\(artistID)/albums") else {
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
                           let name = temp["title"] as? String,
                           let date = temp["release_date"] as? String,
                           let picture = temp["cover"] as? String {
                            let albumInfo = Album(id: id, title: name, cover: picture, release_date: date)
                            self.albums.append(albumInfo)
                            print(albumInfo)
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

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        cell1.artistCover = currentImage
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let temp = albums[indexPath.item]
                cell.configure(with: temp)
                return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width 
        let height = width/2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            if let destinationVC = segue.destination as? DetailsViewController,
               let indexPath = sender as? IndexPath {
                destinationVC.albumID = albums[indexPath.row].id
                destinationVC.albumName = albums[indexPath.row].title
            }
        }
    }


    
}

