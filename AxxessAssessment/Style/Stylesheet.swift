//
//  Stylesheet.swift
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

enum Stylesheet {
    enum Color {
        static var black: UIColor {
            return .black
        }
        
        static var lightGray: UIColor {
            return .lightGray
        }
        
        static var textBlack: UIColor {
            return .black
        }
        
        static var textGray: UIColor {
            return .lightGray
        }
    }
    
    enum Font {
        enum Primary {
            static var medium: String {
                return "AvenirNext-Medium"
            }
            
            static var bold: String {
                return "AvenirNext-Bold"
            }
        }
    }
    
    enum TextStyle {
        static var bodyText: UIFont? {
            return UIFont(name: Stylesheet.Font.Primary.medium, size: 16.0)
        }
        
        static var detailText: UIFont? {
            return UIFont(name: Stylesheet.Font.Primary.medium, size: 12.0)
        }
    }
    
    enum Component {
        enum TabBarView {
            static let selectedBarView = Style<UIView> {
                $0.backgroundColor = Stylesheet.Color.black
            }
            
            static let bottomLineView = Style<UIView> {
                $0.backgroundColor = Stylesheet.Color.lightGray
            }
        }
        
        enum TabView {
            static let titleLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.bodyText
                $0.textColor = Stylesheet.Color.textBlack
            }
        }
        
        enum ImageItemView {
            static let idLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.bodyText
                $0.textColor = Stylesheet.Color.textBlack
            }
            
            static let typeLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.detailText
                $0.textColor = Stylesheet.Color.textGray
            }
            
            static let dateLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.detailText
                $0.textColor = Stylesheet.Color.textGray
            }
        }
        
        enum TextItemView {
            static let idLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.detailText
                $0.textColor = Stylesheet.Color.textGray
            }
            
            static let typeLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.detailText
                $0.textColor = Stylesheet.Color.textGray
            }
            
            static let dateLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.detailText
                $0.textColor = Stylesheet.Color.textGray
            }
            
            static let textLabel = Style<UILabel> {
                $0.font = Stylesheet.TextStyle.bodyText
                $0.textColor = Stylesheet.Color.textBlack
            }
        }
    }
}
