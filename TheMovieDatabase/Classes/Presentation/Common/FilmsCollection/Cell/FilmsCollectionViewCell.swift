//
//  FilmsCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 30.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

class FilmsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var runtimeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: MovieDetails) {
        titleLabel.text = data.title
        
        originalTitleLabel.text = data.originalTitle
        
        genresLabel.text = data.genres.compactMap { $0.name }.joined(separator: ",")
        
        configureVotes(voteAverage: data.voteAverage)
        
        votesLabel.text = "\(data.voteCount)"
        
        configureRuntime(runtime: data.runtime)
    }
    
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
    
    func configureVotes(voteAverage: Double) {
        scoreLabel.text = "\(voteAverage)"
        if voteAverage > 8.0 {
            scoreLabel.tintColor = .customGreen
        } else {
            scoreLabel.tintColor = .customLight
        }
    }
}
