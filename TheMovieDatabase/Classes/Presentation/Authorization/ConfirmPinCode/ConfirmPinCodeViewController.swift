//
//  ConfirmPinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 22.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Экран подтверждения создания пин-кода
final class ConfirmPinCodeViewController: UIViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: AuthorizationCoordinator?
    
    // MARK: - Private Properties
    
    private let pinCodeViewController = PinCodeViewController(
        infoString: "Повторите\nваш пин-код",
        keyboardState: .creation)
    
    private let enteredPinCode: String
    
    // MARK: - Initializers
    
    init(enteredPinCode: String) {
        self.enteredPinCode = enteredPinCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func addPinCodeToDB() {
        
    }
}

// MARK: - PinCodeParentViewController

extension ConfirmPinCodeViewController: PinCodeParentAuthorization {
    
    func pinCodeEntered(pinCode: String) {
        addPinCodeToDB()
        delegate?.loginWithPinCode()
    }
    
    func loginWithFaceId() {}
    
    func exitFromPinCodeScreen() {}
}
