//
//  ImageService.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

final class ImageService: NetworkService {
    func getImage(url: URL, completion: @escaping ( (Swift.Result<UIImage, Error>) -> Void ) ) {
        let request = BasicNetworkRequest(url: url)
        
        getData(request: request) { (result) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkServiceError.failedToParse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
