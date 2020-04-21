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
    
    // MARK: - Private Properties
    
    private let pinCodeViewController = PinCodeViewController()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupColorScheme()
        addChild(pinCodeViewController)
        pinCodeView.addSubview(pinCodeViewController.view)
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
    }
}

// MARK: - PinCodeParentViewController

extension PinCodeAuthorizationViewController: PinCodeParentViewController {
    
    func pinCodeEntered(pinCode: String) {
        
    }
    
    func loginWithFaceId() {
        
    }
    
    func exitFromPinCodeScreen() {
        
    }
}
