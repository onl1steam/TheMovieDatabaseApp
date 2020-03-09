//
//  FavoritesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedStrings()
        let placeholderView = FavoritesPlaceholderView(
            frame: CGRect(x: 0,
                          y: 0,
                          width: containerView.frame.width,
                          height: containerView.frame.height))
        containerView.addSubview(placeholderView)
    }
    
    private func setupLocalizedStrings() {
        favoriteLabel.text = LocalizedStrings.favoriteLabel
    }
}
