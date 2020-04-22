//
//  PinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 20.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

protocol PinCodeParentAuthorization: AnyObject {
    
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
    
    weak var delegate: PinCodeParentAuthorization?
    
    // MARK: - Private Properties
    
    private var pinCode: String = ""
    private let infoString: String
    
    // MARK: - Initializers
    
    init(infoString: String) {
        self.infoString = infoString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScheme()
        infoLabel.text = infoString
        exitButton.isHidden = true
        errorLabel.isHidden = true
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
        guard !pinCode.isEmpty else { return }
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
