//
//  ViewController.swift
//  nasaLibrary
//
//  Created by Nordine Sayah on 24/09/2018.
//  Copyright © 2018 Nordine Sayah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scroll View"
        
        if imageView.image == nil {
            let alert = UIAlertController(title: "Error", message: "Cannot acces to that UR)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var imgURL: URL? {
        didSet {
            imgSearch()
        }
    }
    
    private func imgSearch() {
        if let url = imgURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                self.imageView.image = UIImage(data: imageData as Data)
                self.imageView.sizeToFit()
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = scrollView.bounds.size.width / imageView.bounds.size.width
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
            self.imageView.autoresizingMask = [.flexibleWidth]
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
