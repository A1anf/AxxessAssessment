//
//  Constants.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 9/1/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import Foundation

struct Constants {
    struct Images {
        static let close = "icClose"
        static let brokenImage = "icBrokenImage"
    }
    
    struct Urls {
        static let list = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    }
    
    struct Text {
        static let cancelButtonTitle = "Cancel"
        static let acceptButtonTitle = "Sure"
        static let standardButtonTitle = "OK"
        static let listControllerTitle = "List"
    }
    
    struct ErrorMessages {
        static let standardTitle = "Awww"
        static let standardTryAgain = "Something went wrong, but you can try again?"
        static let itemCannotBeDisplayed = "Looks like this item cannot be displayed."
    }
}
