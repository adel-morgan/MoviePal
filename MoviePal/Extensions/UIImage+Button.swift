//
//  UIImage+Button.swift
//  MoviePal
//
//  Created by adel on 9/7/18.
//  Copyright © 2018 adelmorgan. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var favorite: UIImage? {
        return UIImage(named: "ios-favorites")
    }
    
    static var unfavorite: UIImage? {
        return UIImage(named: "ios-favorites-outline")
    }
}
