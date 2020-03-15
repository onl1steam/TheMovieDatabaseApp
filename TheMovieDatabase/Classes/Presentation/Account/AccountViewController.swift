//
//  AccountViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: RoundedButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Public Properties
    
    let sessionService: Session
    
    // MARK: - Initializers
    
    init(sessionService: Session = ServiceLayer.shared.sessionService) {
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
        
        sessionService.getAccountInfo { response in
            switch response {
            case .success(let info):
                self.nameLabel.text = info.username
                self.emailLabel.text = info.name
                self.sessionService.setupAccountId(accountId: info.id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        sessionService.deleteSession()
        presentInFullScreen(AuthorizationViewController(), animated: true, completion: nil)
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
