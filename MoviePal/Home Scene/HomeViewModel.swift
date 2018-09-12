//
//  HomeViewModel.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func moviesUpdated()
    func movieUpdated(at: Int)
}

final class HomeViewModel {
    
    private let service = MovieService()
    weak var delegate: HomeViewModelDelegate?
    
    private(set) var movies: [Movie] = []
    
    init(delegate: HomeViewModelDelegate? = nil){
        self.delegate = delegate
    }
    
    /**
        Ask the service class for movies
    */
    func getMovies(){
        service.getMovies(){ [unowned self] movies in
            self.movies = movies
            self.delegate?.moviesUpdated()
        }
    }
    
    /**
        Toggle whether or not the user has favorited the movie at the given row
    */
    func toggleFavorite(at row: Int){
        movies[row].favorite = !movies[row].favorite
        delegate?.movieUpdated(at: row)
    }
}
