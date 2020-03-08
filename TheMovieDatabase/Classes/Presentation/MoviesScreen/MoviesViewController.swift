//
//  FilmsViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 08.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesSearchBar: CustomSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        moviesSearchBar.configure()
    }
    
    func setupSearchBar() {
        let textFieldInsideUISearchBar = moviesSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = Colors.light
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(16)
        
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.textColor = Colors.light
    }
}
