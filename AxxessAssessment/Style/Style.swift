//
//  Style.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 9/2/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

/* --------------------------------------------------
 DISCLAIMER:
 
 This was taken from the following url -
 https://hackernoon.com/simple-stylesheets-in-swift-6dda57b5b00d
 
 Credits to @srdanrasic
-------------------------------------------------- */

import UIKit

public struct Style<View: UIView> {
    
    public let style: (View) -> Void
    
    public init(_ style: @escaping (View) -> Void) {
        self.style = style
    }
    
    public func apply(to view: View) {
        style(view)
    }
}
