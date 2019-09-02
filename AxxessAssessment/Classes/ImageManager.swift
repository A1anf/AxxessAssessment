//
//  ImageManager.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ImageManager {
    private let imageService = ImageService()
    
    static let shared = ImageManager()
    
    private init() { }
    
    func retreiveImage(url: URL, completion: @escaping ( (Swift.Result<UIImage, Error>) -> Void ) ) {
        imageService.getImage(url: url, completion: completion)
    }
}
