//
//  ListService.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/30/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation

final class ListService: NetworkService {
    func getList(completion: @escaping ( (Swift.Result<ListViewModel, Error>) -> Void ) ) {
        guard let request = BasicNetworkRequest(urlString: Constants.Urls.list) else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }
        
        getData(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let dataModel = try JSONDecoder().decode(ListDataModel.self, from: data)
                    let viewModel = ListViewModel(model: dataModel)
                    completion(.success(viewModel))
                } catch {
                    completion(.failure(NetworkServiceError.failedToParse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
