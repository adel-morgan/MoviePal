//
//  Data+Debug.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import Foundation

extension Data {
    
    func debug(){
        print("Could not parse data...")
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else {
            print("Network response is not JSON")
            return
        }
        print(json)
    }
}
