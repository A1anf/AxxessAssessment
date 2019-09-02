//
//  ListDataModel.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation

typealias ListDataModel = [ListDetailDataModel]

struct ListDetailDataModel: Codable {
    let id: String
    let type: String
    let date: String?
    let data: String?
}
