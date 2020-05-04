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
    
    // MARK: - IBOutlets
    
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var pinView: PinView!
    
    @IBOutlet private var pinButtons: [UIButton]!
    @IBOutlet private var removeNumberButton: UIButton!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupNavigationBar()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - IBActions
    
    @objc private func arrowBackTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func enterNumber(_ sender: UIButton) {
        pinView.fillCircle()
    }
    
    @IBAction private func removeNumber(_ sender: UIButton) {
        pinView.unfillCircle()
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        infoLabel.textColor = .customLight
        for button in pinButtons {
            button.tintColor = .customLight
        }
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
