//
//  ContainerTableViewCell.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/30/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ContainerTableViewCell: UITableViewCell {
    var containedView: UIView? {
        didSet {
            for subview in self.contentView.subviews {
                subview.removeFromSuperview()
            }
            
            guard let containedView = containedView else {
                return
            }
            
            self.contentView.addSubview(containedView)
            containedView.translatesAutoresizingMaskIntoConstraints = false
            containedView.snp.remakeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
    }
}
