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
    @IBOutlet weak var blankListLabel: UILabel!
    @IBOutlet weak var searchFilmsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedStrings()
    }
    
    private func setupLocalizedStrings() {
        favoriteLabel.text = LocalizedStrings.favoriteLabel
        blankListLabel.text = LocalizedStrings.blankListLabel
        searchFilmsButton.setTitle(LocalizedStrings.searchFilmsButtonText, for: .normal)
    }
}
