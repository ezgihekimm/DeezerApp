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
                   let genres = json["data"] as? [[String: Any]] {
                    for genre in genres {
                        if let id = genre["id"] as? Int,
                           let name = genre["name"] as? String,
                           let picture = genre["picture"] as? String {
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}


