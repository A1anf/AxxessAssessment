//
//  NetworkService.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkServiceError: Error {
    case generic
    case failedToParse
    case invalidURL
}

class NetworkService {
    init() { }
    
    func getData(request: NetworkRequest, completion: @escaping ( (Swift.Result<Data, Error>) -> Void ) ) {
        Alamofire
        .request(
            request.url,
            method: mapToAlamoFireRequestMethod(request.method),
            parameters: request.parameters,
            headers: request.headers)
        .response { (dataResponse) in
            guard let data = dataResponse.data else {
                if let error = dataResponse.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkServiceError.generic))
                }
                return
            }
            completion(.success(data))
        }
    }
    
    private func mapToAlamoFireRequestMethod(_ method: NetworkHttpMethod) -> HTTPMethod {
        switch method {
        case .get: return HTTPMethod.get
        case .post: return HTTPMethod.post
        case .put: return HTTPMethod.put
        case .patch: return HTTPMethod.patch
        case .delete: return HTTPMethod.delete
        }
    }
}
