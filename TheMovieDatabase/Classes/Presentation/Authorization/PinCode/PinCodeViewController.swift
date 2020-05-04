//
//  PinCodeViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 20.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Обработка нажатий на клавиши клавиатуры пин-кода
protocol PinCodeParentAuthorization: AnyObject {
    
    /// Пин-код был введен
    ///
    /// - Parameters:
    ///     - pinCode: Введенный пин-код
    func pinCodeEntered(pinCode: String)
    
    /// Вход по Face ID
    func loginWithFaceId()
    
    /// Выход с экрана ввода пин-кода
    func exitFromPinCodeScreen()
}

class PinCodeViewController: UIViewController {
    
    // MARK: - Types
    
    enum KeyboardState {
        case authorization
        case creation
    }
    
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
    private let keyboardState: KeyboardState
    
    // MARK: - Initializers
    
    init(infoString: String, keyboardState: KeyboardState) {
        self.keyboardState = keyboardState
        self.infoString = infoString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.isHidden = true
        setupColorScheme()
        configureButtons()
        infoLabel.text = infoString
        errorLabel.isHidden = true
    }
    
    // MARK: - IBActions
    
    @IBAction private func enterNumber(_ sender: UIButton) {
        errorLabel.isHidden = true
        pinView.fillCircle()
        guard let text = sender.titleLabel?.text else { return }
        pinCode += text
        configureButtons()
        if pinCode.count == 4 {
            delegate?.pinCodeEntered(pinCode: pinCode)
        }
    }
    
    @IBAction private func removeNumber(_ sender: UIButton) {
        guard !pinCode.isEmpty else { return }
        pinView.unfillCircle()
        pinCode.removeLast()
        configureButtons()
    }
    
    @IBAction private func exitFromPinCodeScreen(_ sender: UIButton) {
        delegate?.exitFromPinCodeScreen()
    }
    
    // MARK: - Public Methods
    
    func showError(errorString: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorString
        pinView.changeCirclesColor(state: .error)
        ViewAnimations.shakeAnimation(on: pinView)
    }
    
    func removePinCode() {
        if !pinCode.isEmpty {
            pinView.removePinCode()
            pinCode.removeAll()
        }
        configureButtons()
    }
    
    // MARK: - Private Methods
    
    private func configureButtons() {
        guard keyboardState == .authorization else { return }
        if pinCode.isEmpty {
            removeNumberButton.setImage(.faceId, for: .normal)
            exitButton.isHidden = false
        } else {
            removeNumberButton.setImage(.backspace, for: .normal)
            exitButton.isHidden = true
        }
    }
    
    private func setupColorScheme() {
        exitButton.tintColor = .customGray
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
