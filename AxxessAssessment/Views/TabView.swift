//
//  TabView.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class TabView: UIView {
    private var titleLabel: UILabel!
    
    var onTapped: ( (TabView, String) -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        titleLabel = UILabel()
        titleLabel.apply(Stylesheet.Component.TabView.titleLabel)
        titleLabel.text = ""
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setup(with title: String) {
        titleLabel.text = title
    }
    
    @objc private func viewTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if let title = titleLabel.text {
            onTapped?(self, title)
        }
    }
}
