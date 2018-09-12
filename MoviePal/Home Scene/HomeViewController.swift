//
//  ViewController.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovies()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func moviesUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func movieUpdated(at row: Int){
        let row = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [row], with: .none)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieTableViewCell.height
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier)
        
        guard let movieCell = cell as? MovieTableViewCell else {
            fatalError("Invalid identifier used")
        }
        movieCell.configure(with: viewModel.movies[indexPath.row])
        //TODO: - delegation is a better approach, but time is short
        movieCell.onFavorite = {
            self.viewModel.toggleFavorite(at: indexPath.row)
        }
        
        return movieCell
    }
}
