//
//  CreatePinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Экран создания пин-кода
final class CreatePinCodeViewController: UIViewController {
    
    @IBOutlet private var pinCodeView: UIView!
    let pinCodeViewController = PinCodeViewController()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupNavigationBar()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        addChild(pinCodeViewController)
        pinCodeView.addSubview(pinCodeViewController.view)
    }
    
    // MARK: - IBActions
    
    @objc private func arrowBackTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        navigationController?.navigationBar.removeBottomLine()
        setupBarItems()
    }
    
    private func setupBarItems() {
        let backArrowItem = UIBarButtonItem(
            image: .arrowBack,
            style: .plain,
            target: self,
            action: #selector(arrowBackTapped(_:)))
        backArrowItem.tintColor = .customLight
        self.navigationItem.leftBarButtonItems =  [backArrowItem]
    }
}
