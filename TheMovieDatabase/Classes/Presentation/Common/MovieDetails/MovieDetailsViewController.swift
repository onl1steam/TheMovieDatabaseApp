//
//  MovieDetailsViewController.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 02.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeDefaultLabel: UILabel!
    @IBOutlet weak var ratesDefaultLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var separationView: UIView!
    
    // MARK: - Public Properties
    
    let movieDetails: MovieDetails
    let imageService: ImageServiceType
    
    weak var delegate: MovieDetailsDelegate?
    
    // MARK: - Initializers
    
    init(movieDetails: MovieDetails, imageService: ImageServiceType = ServiceLayer.shared.imageService) {
        self.movieDetails = movieDetails
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.makeRounded(cornerRadius: 8)
        setupColorScheme()
        setupImageView()
        setupNavigationBar()
        fill(with: movieDetails)
    }
    
    // MARK: - IBActions
    
    @objc func arrowBackTapped(_ sender: UIBarButtonItem) {
        delegate?.arrowBackTapped()
    }
    
    @objc func favoriteTapped(_ sender: UIBarButtonItem) {
        delegate?.favoriteTapped()
    }
    
    // MARK: - Private Methods
    
    private func fill(with movieDetails: MovieDetails) {
        loadImage(path: movieDetails.posterPath)
        titleLabel.text = movieDetails.title
        originalTitleLabel.text = movieDetails.originalTitle
        genresLabel.text = movieDetails.genres.compactMap { $0.name }.joined(separator: ",")
        configureRuntime(movieDetails.runtime)
        configureVotes(movieDetails.voteAverage)
        votesCountLabel.text = "\(movieDetails.voteCount)"
        configureDescription(movieDetails.overview)
    }
    
    private func loadImage(path: String?) {
        guard let posterPath = path else { return }
        imageService.image(posterPath: posterPath, width: nil) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let image):
                self.posterImageView.image = image
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func setupColorScheme() {
        view.backgroundColor = .backgroundBlack
        titleLabel.textColor = .customLight
        originalTitleLabel.textColor = .customGray
        genresLabel.textColor = .customLight
        runtimeDefaultLabel.textColor = .customGray
        ratesDefaultLabel.textColor = .customGray
        runtimeLabel.textColor = .customLight
        ratesLabel.textColor = .customLight
        minutesLabel.textColor = .customLight
        votesCountLabel.textColor = .customGray
        descriptionTextView.backgroundColor = .backgroundBlack
        descriptionTextView.textColor = .customLight
        separationView.backgroundColor = .darkBlue
    }
    
    private func setupImageView() {
        posterImageView.makeRounded(cornerRadius: 8)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .backgroundBlack
        navigationController?.navigationBar.barTintColor = .backgroundBlack
        setupBarItems()
    }
    
    private func setupBarItems() {
        let backArrowItem = UIBarButtonItem(
            image: .arrowBack,
            style: .plain,
            target: self,
            action: #selector(arrowBackTapped(_:)))
        let favoriteItem = UIBarButtonItem(
            image: .favorite,
            style: .plain,
            target: self,
            action: #selector(favoriteTapped(_:)))
        favoriteItem.tintColor = .customLight
        backArrowItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems = [favoriteItem]
        self.navigationItem.leftBarButtonItems = [backArrowItem]
    }
    
    private func configureVotes(_ voteAverage: Double) {
        ratesLabel.text = "\(voteAverage)"
        if voteAverage > 8.0 {
            ratesLabel.textColor = .customGreen
        } else {
            ratesLabel.textColor = .customLight
        }
    }
    
    private func configureRuntime(_ runtime: Int?) {
        guard let movieRuntime = runtime else {
            runtimeLabel.text = "-"
            return
        }
        runtimeLabel.text = "\(movieRuntime)"
    }
    
    private func configureDescription(_ description: String?) {
        guard let overview = description else {
            descriptionTextView.text = ""
            return
        }
        descriptionTextView.text = overview
    }
}
