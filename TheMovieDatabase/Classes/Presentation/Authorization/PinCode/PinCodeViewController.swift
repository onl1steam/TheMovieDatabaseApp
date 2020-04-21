//
//  PinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 20.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol PinCodeParentViewController: AnyObject {
    
    func pinCodeEntered(pinCode: String)
    
    func loginWithFaceId()
    
    func exitFromPinCodeScreen()
}

class PinCodeViewController: UIViewController {
    
    // MARK: - IBOutlts
    
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var pinView: PinView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var exitButton: UIButton!
    @IBOutlet private var removeNumberButton: UIButton!
    @IBOutlet private var pinButtons: [UIButton]!
    
    // MARK: - Public Properties
    
    weak var delegate: PinCodeParentViewController?
    
    // MARK: - Private Properties
    
    private var pinCode: String = ""
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        exitButton.isHidden = true
    }
    
    // MARK: - IBActions
    
    @IBAction private func enterNumber(_ sender: UIButton) {
        pinView.fillCircle()
        guard let text = sender.titleLabel?.text else { return }
        pinCode += text
        if pinCode.count == 4 {
            delegate?.pinCodeEntered(pinCode: pinCode)
        }
    }
    
    @IBAction private func removeNumber(_ sender: UIButton) {
        pinView.unfillCircle()
        pinCode.removeLast()
    }
    
    @IBAction private func exitFromPinCodeScreen(_ sender: UIButton) {
        delegate?.exitFromPinCodeScreen()
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        infoLabel.textColor = .customLight
        errorLabel.textColor = .customRed
        setupKeyboardColorScheme()
    }
    
    private func setupKeyboardColorScheme() {
        for button in pinButtons {
            button.tintColor = .customLight
        }
    }
}
