//
//  MovieAPI.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import Foundation

/**
    A struct that contains general API information
*/
fileprivate struct Config {
    static let key = "b9e885864179810a25e84be871c8d698"
    static let server = "https://api.themoviedb.org/3"
    
    //TODO: - get the current config instead of harcoding
    fileprivate struct Image {
        static let server = "https://image.tmdb.org/t/p/w500/"
    }
}

/**
    A struct used to format API arguments
*/
fileprivate struct Formatter {
    
    /**
        A DateFormatter used to convert a date to the API expected format
        The purpose of this is to keep the date formatter in memory, since creating them is expensive
    */
    static var date: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy_MM_dd"
        return df
    }
}

/**
    An enum used to get API arguments
*/
fileprivate enum Arg: String {
    
    case recent = "sort_by=release_date.desc"
    case popular = "vote_count.gte=10"
    case english = "with_original_language=en"
    case released
    
    /**
        Takes an array of arguments and returns the corresponding URL string
    */
    static func url(with arguments: [Arg]) -> String{
        return arguments.map(){ $0.stringValue }.joined(separator: "&")
    }

    /**
        Returns the proper string for the given argument
    */
    var stringValue: String {
        switch self {
        case .released:
            return Arg.releasedOnly()
        default:
            return rawValue
        }
    }
    
    /**
        Provides the argument that enables only released movies to be returned
    */
    private static func releasedOnly() -> String {
        // get the current date and format it
        let dateArg = Formatter.date.string(from: Date())
        
        // only allow movies that are released before this date
        return "&release_date.lte=\(dateArg)"
    }
}

fileprivate enum Path: String {
    case search
    case discover
    case find
    
    var base: String {
        return "\(Config.server)/\(self.rawValue)/movie?api_key=\(Config.key)"
    }
}

struct MovieAPI {
    
    //        https://api.themoviedb.org/3/discover/movie?api_key=b9e885864179810a25e84be871c8d698&sort_by=release_date.desc&vote_count.gte=10&release_date.lte=2018_09_07&with_original_language=en

    static func recentPopularMovies(limit: Int) -> String {
        return Path.discover.base + "&" + Arg.url(with: [.recent, .popular, .english, .released])
    }
    
    static func image(with path: String) -> String {
        return Config.Image.server + path
    }
}
