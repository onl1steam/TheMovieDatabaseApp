//
//  FilmsCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

final class FilmsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var runtimeImageView: UIImageView!
    @IBOutlet weak var posterLoadingActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupColorScheme()
        posterLoadingActivityIndicator.isHidden = true
        posterLoadingActivityIndicator.style = .white
        posterLoadingActivityIndicator.tintColor = .customLight
    }
    
    // MARK: - Public Methods
    
    func configure(data: MovieDetails) {
        titleLabel.text = data.title
        
        originalTitleLabel.text = "\(data.originalTitle) (\(data.releaseDate))"
        
        genresLabel.text = data.genres.compactMap { $0.name }.joined(separator: ",")
        
        configureVotes(voteAverage: data.voteAverage)
        
        votesLabel.text = "\(data.voteCount)"
        
        configureRuntime(runtime: data.runtime)
    }
    
    func configureImage(_ image: UIImage) {
        posterImageView.makeRounded(cornerRadius: 8)
        posterImageView.image = image
    }
    
    func toggleActivityIndicator() {
        let isHidden = posterLoadingActivityIndicator.isHidden
        if isHidden {
            posterLoadingActivityIndicator.isHidden = false
            posterLoadingActivityIndicator.startAnimating()
        } else {
            posterLoadingActivityIndicator.isHidden = true
            posterLoadingActivityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    
    private func configureRuntime(runtime: Int?) {
        guard let time = runtime else {
            runtimeImageView.isHidden = true
            runtimeLabel.isHidden = true
            return
        }
        runtimeLabel.text = "\(time)мин"
        runtimeLabel.isHidden = false
        runtimeImageView.isHidden = false
    }
    
    private func configureVotes(voteAverage: Double) {
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
