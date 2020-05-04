//
//  AccountViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: RoundedButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    let imageService: ImageServiceType
    
    // MARK: - Initializers
    
    init(
        sessionService: Session = ServiceLayer.shared.sessionService,
        imageService: ImageServiceType = ServiceLayer.shared.imageService) {
        self.imageService = imageService
        self.sessionService = sessionService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        setupColorScheme()
        setupLocalizedStrings()
        avatarImageView.makeRounded()
        loadAccountInfo()
    }
    
    // MARK: - Public methods
    
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func loadAccountInfo() {
        
        sessionService.accountInfo { [weak self] response in
            guard let self = self else { return }
            var avatarHash: String?
            switch response {
            case .success(let info):
                self.nameLabel.text = info.username
                self.emailLabel.text = info.name
                avatarHash = info.avatar.gravatar.hash
                self.sessionService.setupAccountId(accountId: info.id)
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
            guard let hash = avatarHash else { return }
            self.loadAvatar(hash: hash)
        }
    }
    
    func loadAvatar(hash: String) {
        imageService.avatar(avatarPath: hash) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let info):
                guard let image = UIImage(data: info) else { return }
                self.avatarImageView.image = image
                self.errorLabel.isHidden = true
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
    
    func logout() {
        sessionService.deleteSession { [weak self] response in
            switch response {
            case .success(let isSucceed):
                if !isSucceed {
                    self?.showError(message: "Не удалось деавторизоваться.")
                }
            case .failure(let error):
                self?.showError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        logout()
        presentInFullScreen(AuthorizationViewController(), animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = Colors.backgroundBlack
        nameLabel.tintColor = Colors.light
        emailLabel.tintColor = Colors.gray
        logoutButton.backgroundColor = Colors.accountButtonBackground
        logoutButton.tintColor = Colors.purpure
        errorLabel.tintColor = Colors.red
    }
    
    private func setupLocalizedStrings() {
        logoutButton.setTitle(AccountScreenStrings.logoutButtonText, for: .normal)
    }
}
