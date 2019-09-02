//
//  UIView+Style.swift
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

extension UIView {
    public convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }
    
    public func apply<V>(_ style: Style<V>) {
        guard let view = self as? V else {
            print("Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
}
