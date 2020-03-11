//
//  AccountViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var logoutButton: RoundedButton!
    
    let sessionService: Session
    
    init(sessionService: Session = ServiceLayer.shared.sessionService) {
        self.sessionService = sessionService
        super.init(nibName: "AccountViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedStrings()
        avatarImageView.makeRounded()
    }
    
    private func setupLocalizedStrings() {
        logoutButton.setTitle(AccountScreenStrings.logoutButtonText, for: .normal)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        sessionService.deleteSession()
        presentInFullScreen(AuthorizationViewController(), animated: true, completion: nil)
    }
}
