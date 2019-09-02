//
//  ImageItemViewModel.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

struct ImageItemViewModel: ListDetailViewModelRepresentable {
    let model: ListDetailDataModel
    
    init(model: ListDetailDataModel) {
        self.model = model
    }
    
    var imageUrl: URL? {
        guard let urlString = model.data else {
            return nil
        }
        return URL(string: urlString)
    }
}
