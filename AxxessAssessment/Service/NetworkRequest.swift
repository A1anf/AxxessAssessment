//
//  NetworkRequest.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation

public enum NetworkHttpMethod {
    case get
    case post
    case put
    case patch
    case delete
}

protocol NetworkRequest {
    var url: URL { get set }
    var method: NetworkHttpMethod { get set }
    var parameters: [String: Any]? { get set }
    var headers: [String: String]? { get set }
}

struct BasicNetworkRequest: NetworkRequest {
    var url: URL
    var method: NetworkHttpMethod
    var parameters: [String : Any]?
    var headers: [String : String]?
    
    init(url: URL, method: NetworkHttpMethod = .get) {
        self.url = url
        self.method = method
    }
    
    init?(urlString: String, method: NetworkHttpMethod = .get) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
        self.method = method
    }
}
