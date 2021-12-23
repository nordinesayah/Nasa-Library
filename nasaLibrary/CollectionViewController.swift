//
//  ViewController.swift
//  nasaLibrary
//
//  Created by Nordine Sayah on 24/09/2018.
//  Copyright © 2018 Nordine Sayah. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    let urlImg = [
        "https://www.nasa.gov/sites/default/files/thumbnails/image/potw1838a.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/churning.jpeg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/atmosphere_geo5_2018235_eq.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/pia22686-16.jpg",
        "https://www.nasa.gov/sites/default/files/thumbnails/image/iss056e006994_lrg.jpg",
        "TEST"
    ]
    
    var networkCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlImg.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as! ViewController
        destination.imgURL = URL(string: urlImg[indexPath.row])
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = .black
        if let url = URL(string: urlImg[indexPath.row]) {
            cell.loading.startAnimating()
            networkCount += 1
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            DispatchQueue.global(qos: .userInteractive).async {
                let lastImageURL = url
                if url == lastImageURL {
                    if let imageData = NSData(contentsOf: url) {
                        DispatchQueue.main.async { [weak weakSelf = cell] in
                            weakSelf?.imgView.image = UIImage(data: imageData as Data)
                            cell.loading.stopAnimating()
                            self.networkCount -= 1
                            if self.networkCount == 0 {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    } else {
                        DispatchQueue.main.async { [weak weakSelf = cell] in
                            weakSelf?.imgView.image = nil
                            self.urlNotFound(url: self.urlImg[indexPath.row])
                            self.networkCount -= 1
                            if self.networkCount == 0 {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func urlNotFound(url: String){
        let alert = UIAlertController(title: "Error", message: "Cannot acces to \(url)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
