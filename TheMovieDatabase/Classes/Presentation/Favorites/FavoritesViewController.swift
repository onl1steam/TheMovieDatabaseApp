//
//  FavoritesViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Делегат для связи с Child ViewController'ами
protocol FavoritesViewControllerDelegate: class {
    
    /// Нажатие кнопки поиска
    func searchTapped()
}

final class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    
    let filmsCollectionVC = FilmsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    let placeholderVC = FavoritesStubViewController()
    
    weak var delegate: FavoritesCoordinatorType?
    
    // MARK: - Initializers
    
    init(sessionService: Session = ServiceLayer.shared.sessionService) {
        self.sessionService = sessionService
        super.init(nibName: nil, bundle: nil)
        placeholderVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupLocalizedStrings()
        
        placeholderVC.view.frame.size = containerView.bounds.size
        addChild(placeholderVC)
        containerView.addSubview(placeholderVC.view)
        didMove(toParent: self)
        setupNavigationBar()
    }
    
    // MARK: - IBAction
    
    @objc func searchButtonTapped() {
        
    }
    
    @objc func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        favoriteLabel.tintColor = .customLight
    }
    
    private func setupLocalizedStrings() {
        favoriteLabel.text = FavoritesScreenStrings.favoriteLabel
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupBarItems() {
        let listItem = UIBarButtonItem(
            image: .listButton,
            style: .plain,
            target: self,
            action: #selector(changeAppearance(_:)))
        listItem.tintColor = .customLight
        let searchItem = UIBarButtonItem(
            image: .search,
            style: .plain,
            target: nil,
            action: #selector(searchButtonTapped))
        searchItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems =  [listItem, searchItem]
    }
}

// MARK: - FavoritesViewControllerDelegate

extension FavoritesViewController: FavoritesViewControllerDelegate {
    
    func searchTapped() {
        print("Search text tapped")
    }
}

// MARK: - CollectionParentDelegate

extension FavoritesViewController: CollectionParentDelegate {
    
    func elementTapped(data: MovieDetails) {
        delegate?.showMovieDetails(data: data)
    }
}
