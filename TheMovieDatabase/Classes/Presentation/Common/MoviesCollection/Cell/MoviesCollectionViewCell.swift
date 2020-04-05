//
//  MoviesCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

/// Ячейка в коллекции отображающей фильмы
final class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var originalTitleLabel: UILabel!
    @IBOutlet private var genresLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var votesLabel: UILabel!
    @IBOutlet private var runtimeLabel: UILabel!
    @IBOutlet private var runtimeImageView: UIImageView!
    @IBOutlet private var posterLoadingActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupColorScheme()
        setupActivityIndicator()
    }
    
    // MARK: - Public Methods
    
    func configure(movie: MovieDetails) {
        titleLabel.text = movie.title
        originalTitleLabel.text = "\(movie.originalTitle) (\(movie.releaseDate))"
        genresLabel.text = movie.genres.compactMap { $0.name }.joined(separator: ",")
        setupVotesColor(voteAverage: movie.voteAverage)
        votesLabel.text = "\(movie.voteCount)"
        checkRuntimeValidity(runtime: movie.runtime)
    }
    
    func setupImage(_ image: UIImage) {
        posterImageView.image = image
        posterImageView.makeRounded(cornerRadius: 8.0)
    }
    
    func setPlaceholderImage() {
        posterImageView.image = nil
    }
    
    func toggleActivityIndicator() {
        posterLoadingActivityIndicator.isHidden ?
            posterLoadingActivityIndicator.startAnimating(): posterLoadingActivityIndicator.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func setupActivityIndicator() {
        posterLoadingActivityIndicator.isHidden = true
        posterLoadingActivityIndicator.style = .white
        posterLoadingActivityIndicator.tintColor = .customLight
        posterLoadingActivityIndicator.hidesWhenStopped = true
    }
    
    private func checkRuntimeValidity(runtime: Int?) {
        guard let time = runtime else {
            runtimeImageView.isHidden = true
            runtimeLabel.isHidden = true
            return
        }
        runtimeLabel.text = "\(time) мин"
        runtimeLabel.isHidden = false
        runtimeImageView.isHidden = false
    }
    
    private func setupVotesColor(voteAverage: Double) {
        scoreLabel.text = "\(voteAverage)"
        if voteAverage > 8.0 {
            scoreLabel.textColor = .customGreen
        } else {
            scoreLabel.textColor = .customLight
        }
    }
    
    private func setupColorScheme() {
        titleLabel.tintColor = .customLight
        originalTitleLabel.tintColor = .customGray
        genresLabel.tintColor = .customLight
        votesLabel.tintColor = .customGray
        runtimeLabel.tintColor = .customLight
    }
}
