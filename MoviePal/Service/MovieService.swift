//
//  MovieService.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import Foundation

final class MovieService {
    
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    func getMovies(completion: @escaping ([Movie])->()){
        
        let urlString = MovieAPI.recentPopularMovies(limit: 20)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }
        
        session.dataTask(with: url){ [unowned self] data, response, error in
            
            if let e = error {
                print(e.localizedDescription)
                completion([])
                return
            }
            
            guard let serverData = data else {
                print("No network data")
                completion([])
                return
            }
            
            do{
                let result = try self.decoder.decode(MovieResult.self, from: serverData)
                completion(result.movies)
            }catch{
                print(error.localizedDescription)
                serverData.debug()
                completion([])
            }
        }.resume()
    }
    
}
