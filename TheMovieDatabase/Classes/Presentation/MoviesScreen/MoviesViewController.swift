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
    @IBOutlet weak var moviesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupLocalizedStrings()
        moviesSearchBar.configure()
    }
    
    private func setupLocalizedStrings() {
        moviesLabel.text = LocalizedStrings.moviesLabel
        moviesSearchBar.placeholder = LocalizedStrings.searchBarPlaceholder
    }
    
    func setupSearchBar() {
        let textFieldInsideUISearchBar = moviesSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = Colors.light
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(16)
        
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.textColor = Colors.light
    }
}
