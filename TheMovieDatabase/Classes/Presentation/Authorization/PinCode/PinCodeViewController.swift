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
        errorLabel.isHidden = true
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
