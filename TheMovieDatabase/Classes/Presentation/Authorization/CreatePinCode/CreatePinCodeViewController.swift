//
//  CreatePinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 07.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class CreatePinCodeViewController: UIViewController {
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var pinView: PinView!
    
    @IBOutlet var pinButtons: [UIButton]!
    @IBOutlet var removeNumberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        setupNavigationBar()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func arrowBackTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enterNumber(_ sender: UIButton) {
        pinView.fillCircle()
    }
    
    @IBAction func removeNumber(_ sender: UIButton) {
        pinView.unfillCircle()
    }
    
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
