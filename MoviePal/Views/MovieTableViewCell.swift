//
//  MovieTableViewCell.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    static let height: CGFloat = 100.0
    static let identifier = "MovieCell"

    /**
        Function that executes when the cell's favorite button is tapped
    */
    var onFavorite: (()->())?
    
    func configure(with movie: Movie){
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.date
        ratingLabel.text = movie.score?.string
        set(favorite: movie.favorite)
        set(image: movie.image)
    }
    
    private func set(image: String?){
        guard let img = image else { return }
        
        let path = MovieAPI.image(with: img)
        guard let url = URL(string: path) else {
            print("Bad image path")
            return
        }
        
        posterImageView.kf.setImage(with: url)
    }
    
    private func set(favorite: Bool){
        if favorite {
            favoriteButton.setImage(UIImage.favorite, for: .normal)
        }else {
            favoriteButton.setImage(UIImage.unfavorite, for: .normal)
        }
    }
    
    @IBAction func favoriteButtonTapped() {
        onFavorite?()
    }
    
}
