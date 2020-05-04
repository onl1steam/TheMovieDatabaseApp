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
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var originalTitleLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var runtimeDefaultLabel: UILabel!
    @IBOutlet private var ratesDefaultLabel: UILabel!
    @IBOutlet private var runtimeLabel: UILabel!
    @IBOutlet private var ratesLabel: UILabel!
    @IBOutlet private var minutesLabel: UILabel!
    @IBOutlet private var votesCountLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var separationView: UIView!
    
    // MARK: - Public Properties
    
    let movieDetails: MovieDetails
    let imageService: ImageServiceType
    let sessionService: Session
    
    weak var delegate: MovieDetailsDelegate?
    
    // MARK: - Private Properties
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(.favorite, for: .normal)
        button.tintColor = .customLight
        return button
    }()
    
    private var isFavorite: Bool
    
    // MARK: - Initializers
    
    init(movieDetails: MovieDetails,
         imageService: ImageServiceType = ServiceLayer.shared.imageService,
         sessionService: Session = ServiceLayer.shared.sessionService,
         isFavorite: Bool) {
        self.sessionService = sessionService
        self.movieDetails = movieDetails
        self.imageService = imageService
        self.isFavorite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButton()
        posterImageView.makeRounded(cornerRadius: 8)
        setupColorScheme()
        setupImageView()
        setupNavigationBar()
        fill(with: movieDetails)
        navigationController?.navigationBar.removeBottomLine()
        favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - IBActions
    
    @objc private func arrowBackTapped(_ sender: UIBarButtonItem) {
        delegate?.arrowBackTapped()
    }
    
    @objc private func favoriteTapped(_ sender: UIButton) {
        isFavorite.toggle()
        
        setupFavoriteButton()
        
        sessionService.markAsFavorite(
            mediaType: "movie",
            mediaId: movieDetails.id,
            favorite: isFavorite) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success:
                    self.delegate?.favoriteTapped()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupFavoriteButton() {
        if isFavorite {
            favoriteButton.setImage(.favoriteFilled, for: .normal)
        } else {
            favoriteButton.setImage(.favorite, for: .normal)
        }
    }
    
    private func fill(with movieDetails: MovieDetails) {
        loadImage(path: movieDetails.posterPath)
        titleLabel.text = movieDetails.title
        originalTitleLabel.text = movieDetails.originalTitle
        genresLabel.text = movieDetails.genres.compactMap { $0.name }.joined(separator: ",")
        checkRuntimeValidity(movieDetails.runtime)
        setupVotesColor(movieDetails.voteAverage)
        votesCountLabel.text = "\(movieDetails.voteCount)"
        checkDescriptionValidity(movieDetails.overview)
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
        let favoriteItem = UIBarButtonItem(customView: favoriteButton)
        backArrowItem.tintColor = .customLight
        self.navigationItem.rightBarButtonItems = [favoriteItem]
        self.navigationItem.leftBarButtonItems = [backArrowItem]
    }
    
    private func setupVotesColor(_ voteAverage: Double) {
        ratesLabel.text = "\(voteAverage)"
        if voteAverage > 8.0 {
            ratesLabel.textColor = .customGreen
        } else {
            ratesLabel.textColor = .customLight
        }
    }
    
    private func checkRuntimeValidity(_ runtime: Int?) {
        guard let movieRuntime = runtime else {
            runtimeLabel.text = "-"
            return
        }
        runtimeLabel.text = "\(movieRuntime)"
    }
    
    private func checkDescriptionValidity(_ description: String?) {
        guard let overview = description else {
            descriptionTextView.text = ""
            return
        }
        descriptionTextView.text = overview
    }
}
