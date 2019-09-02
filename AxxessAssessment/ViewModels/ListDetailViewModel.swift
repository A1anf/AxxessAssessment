//
//  ListDetailViewModel.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation

enum ListDetailViewModel {
    case image(ImageItemViewModel)
    case text(TextItemViewModel)
    case other(TextItemViewModel)
    
    init?(model: ListDetailDataModel) {
        switch model.type {
        case "image":
            let imageItemViewModel = ImageItemViewModel(model: model)
            self = .image(imageItemViewModel)
        case "text":
            let textItemViewModel = TextItemViewModel(model: model)
            self = .text(textItemViewModel)
        case "other":
            let textItemViewModel = TextItemViewModel(model: model)
            self = .other(textItemViewModel)
        default:
            return nil
        }
    }
}

protocol ListDetailViewModelRepresentable {
    var model: ListDetailDataModel { get }
    
    init(model: ListDetailDataModel)
}

extension ListDetailViewModelRepresentable {
    var type: String {
        return model.type
    }
    
    var idText: String {
        return "ID: \(model.id)"
    }
    
    var typeText: String {
        return model.type
    }
    
    var dateText: String {
        return model.date ?? ""
    }
}
