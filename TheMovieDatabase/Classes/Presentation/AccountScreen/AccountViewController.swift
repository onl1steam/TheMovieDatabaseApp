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
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.makeRounded()
    }
}
