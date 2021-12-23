//
//  CollectionViewCell.swift
//  nasaLibrary
//
//  Created by Nordine Sayah on 24/09/2018.
//  Copyright © 2018 Nordine Sayah. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.loading.hidesWhenStopped = true
        self.loading.color = .white
    }
}
