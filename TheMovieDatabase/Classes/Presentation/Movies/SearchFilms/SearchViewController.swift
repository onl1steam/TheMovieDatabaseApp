//
//  SearchViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 31.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let navigationBar: CustomSearchBar = {
        let rect = CGRect(x: 0, y: 0, width: 280, height: 48)
        let navBar = CustomSearchBar(frame: rect)
        return navBar
    }()
    
    private let searchStubVC = SearchStubViewController()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundBlack
        setupNavigationBar()
        setupContainerConstraints()
        
        addChild(searchStubVC)
        searchStubVC.view.frame.size = containerView.bounds.size
        containerView.addSubview(searchStubVC.view)
        didMove(toParent: self)
    }
    
    // MARK: - IBActions
    
    @objc func changeAppearance(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Private Methods
    
    private func setupBarItems() {
        navigationItem.titleView = navigationBar
        let listItem = UIBarButtonItem(
            image: .listButton,
            style: .plain,
            target: self,
            action: #selector(changeAppearance(_:)))
        listItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems =  [listItem]
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupContainerConstraints() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
}
