//
//  AccountViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: RoundedButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
        setupColorScheme()
        setupLocalizedStrings()
        avatarImageView.makeRounded()
        loadAccountInfo()
    }
    
    // MARK: - IBAction
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        sessionService.deleteSession()
        presentInFullScreen(AuthorizationViewController(), animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func loadAccountInfo() {
        
        sessionService.getAccountInfo { response in
            var avatarHash: String?
            switch response {
            case .success(let info):
                self.nameLabel.text = info.username
                self.emailLabel.text = info.name
                avatarHash = info.avatar.gravatar.hash
                self.sessionService.setupAccountId(accountId: info.id)
            case .failure(let error):
                print(error.localizedDescription)
            }
            guard let hash = avatarHash else { return }
            self.imageService.getAvatar(avatarPath: hash) { response in
                switch response {
                case .success(let info):
                    guard let image = UIImage(data: info) else { return }
                    self.avatarImageView.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupColorScheme() {
        view.backgroundColor = Colors.backgroundBlack
        nameLabel.tintColor = Colors.light
        emailLabel.tintColor = Colors.gray
        logoutButton.backgroundColor = Colors.accountButtonBackground
        logoutButton.tintColor = Colors.purpure
    }
    
    private func setupLocalizedStrings() {
        logoutButton.setTitle(AccountScreenStrings.logoutButtonText, for: .normal)
    }
}
