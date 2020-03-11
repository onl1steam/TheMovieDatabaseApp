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
        let placeholderView = FavoritesPlaceholderView(frame: CGRect(
            x: 0,
            y: 0,
            width: containerView.frame.width,
            height: containerView.frame.height))
        containerView.addSubview(placeholderView)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = Colors.backgroundBlack
        navigationController?.navigationBar.barTintColor = Colors.backgroundBlack
        setupBarItems()
    }
    
    func setupBarItems() {
        let listItem = UIBarButtonItem(
            image: Images.listButton,
            style: .plain,
            target: self,
            action: #selector(changeAppearance(_:)))
        listItem.tintColor = Colors.light
        let searchItem = UIBarButtonItem(
            image: Images.search,
            style: .plain,
            target: nil,
            action: #selector(searchButtonTapped))
        searchItem.tintColor = Colors.light
        self.navigationItem.rightBarButtonItems =  [listItem, searchItem]
        
    }
    
    @objc func searchButtonTapped() {
        
    }
    
    @objc func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    private func setupLocalizedStrings() {
        favoriteLabel.text = FavoritesScreenStrings.favoriteLabel
    }
}
