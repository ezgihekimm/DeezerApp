//
//  DetailsViewController.swift
//  Appcent1
//
//  Created by Ezgi Hekim on 14.05.2023.
//

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var albumID: Int = 0
    var albumName: String = ""
    var albumImage: String = ""
    var song = [Song]()
    var musicPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = albumName
        callAPI()
    }
    
    func callAPI() {
        guard let url = URL(string: "https://api.deezer.com/album/\(albumID)/tracks") else {
            return
        }
        print("\(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let tracks = json["data"] as? [[String: Any]] {
                    for track in tracks {
                        if let id = track["id"] as? Int,
                           let title = track["title"] as? String,
                           let duration = track["duration"] as? Int,
                           let preview = track["preview"] as? String {
                            let newSong = Song(id: id, title: title, duration: duration, preview: preview, cover: self.albumImage)
                            self.song.append(newSong)
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
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! DetailsCollectionViewCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
    
        let temp = song[indexPath.item]
        cell.configure(with: temp)

        // Müzik çalma özelliğini eklemek için, hücredeki "play" düğmesine ekleme yapın
        cell.playButtonAction = { [weak self] in
            guard let self = self else { return }
            let previewURL = temp.preview
            
            // Müzik öğesi mevcutsa, durdurun
            if let player = self.musicPlayer {
                player.pause()
                self.musicPlayer = nil
            }
            
            // Örnek olarak URL kullanarak müzik çalar oluşturun ve çalmaya başlayın
            if let url = URL(string: previewURL) {
                let playerItem = AVPlayerItem(url: url)
                self.musicPlayer = AVPlayer(playerItem: playerItem)
                self.musicPlayer?.play()
            }
        }

                return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        song.count
    }
}
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
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
    
}

