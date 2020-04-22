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
    
    // MARK: - Public Properties
    
    weak var delegate: AuthorizationCoordinator?
    
    // MARK: - Private Properties
    
    private let pinCodeViewController = PinCodeViewController(
        infoString: "Придумайте пин-код\nдля быстрого входа",
        keyboardState: .creation)
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pinCodeViewController.delegate = self
        setupColorScheme()
        setupNavigationBar()
        view.addSubview(pinCodeViewController.view)
        constraintContainerView()
        addChild(pinCodeViewController)
    }
    
    // MARK: - IBActions
    
    @objc private func arrowBackTapped(_ sender: UIBarButtonItem) {
        delegate?.previousViewController()
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
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
    
    private func constraintContainerView() {
        pinCodeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = pinCodeViewController.view.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 24)
        let trailingConstraint = pinCodeViewController.view.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -24)
        let bottomConstraint = pinCodeViewController.view.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 0)
        let topConstraint = pinCodeViewController.view.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 55)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint, topConstraint])
    }
}

extension CreatePinCodeViewController: PinCodeParentAuthorization {
    
    func pinCodeEntered(pinCode: String) {
        delegate?.confirmPinCode(enteredPinCode: pinCode)
    }
    
    func loginWithFaceId() {}
    
    func exitFromPinCodeScreen() {}
}
