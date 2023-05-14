import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        callAPI()
    }
    func callAPI() {
        guard let url = URL(string: "https://api.deezer.com/genre") else {
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
                            let category = Category(id: id, name: name, picture: picture)
                            self.categories.append(category)
                            print(category)
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
    
    @IBAction func tabBarItemTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToLike", sender: self)
    }

}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let category = categories[indexPath.item]
                cell.configure(with: category)
                return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
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
        performSegue(withIdentifier: "goToArtist", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToArtist" {
            if let destinationVC = segue.destination as? ArtistsViewController,
               let indexPath = sender as? IndexPath {
                destinationVC.categoryID = categories[indexPath.row].id
                destinationVC.categoryName = categories[indexPath.row].name
            }
            
        }
    }

}






