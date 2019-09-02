//
//  TextItemViewModel.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

struct TextItemViewModel: ListDetailViewModelRepresentable {
    let model: ListDetailDataModel
    
    init(model: ListDetailDataModel) {
        self.model = model
    }
    
    var fullText: String {
        return model.data ?? ""
    }
}
