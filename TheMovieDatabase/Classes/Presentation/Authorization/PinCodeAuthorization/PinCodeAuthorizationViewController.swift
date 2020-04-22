//
//  PinCodeAuthorizationViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 21.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class PinCodeAuthorizationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var pinCodeView: UIView!
    
    // MARK: - Public Properties
    
    weak var delegate: AuthorizationCoordinator?
    
    // MARK: - Private Properties
    
    private let pinCodeViewController = PinCodeViewController(
        infoString: "Виталий Белов",
        keyboardState: .authorization)
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        pinCodeViewController.delegate = self
        setupColorScheme()
        addPinCodeViewController()
    }
    
    // MARK: - Private Methods
    
    private func addPinCodeViewController() {
        pinCodeViewController.view.frame = pinCodeView.bounds
        pinCodeViewController.delegate = self
        addChild(pinCodeViewController)
        pinCodeView.addSubview(pinCodeViewController.view)
    }
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
    }
}

// MARK: - PinCodeParentViewController

extension PinCodeAuthorizationViewController: PinCodeParentAuthorization {
    
    func pinCodeEntered(pinCode: String) {
        delegate?.enterApp()
    }
    
    func loginWithFaceId() {}
    
    func exitFromPinCodeScreen() {}
}
