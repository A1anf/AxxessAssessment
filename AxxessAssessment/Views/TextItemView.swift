//
//  TextItemView.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class TextItemView: UIView {
    private var idLabel: UILabel!
    private var typeLabel: UILabel!
    private var dateLabel: UILabel!
    private var textLabel: UILabel!
    private var textStackView: UIStackView!
    
    enum UIState {
        case cell
        case normal
    }
    
    var viewType: UIState = .normal {
        didSet {
            setupUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        idLabel = UILabel()
        idLabel.apply(Stylesheet.Component.TextItemView.idLabel)
        
        typeLabel = UILabel()
        typeLabel.apply(Stylesheet.Component.TextItemView.typeLabel)
        
        dateLabel = UILabel()
        dateLabel.apply(Stylesheet.Component.TextItemView.dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        
        textLabel = UILabel()
        textLabel.apply(Stylesheet.Component.TextItemView.textLabel)
        
        textStackView = UIStackView()
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textStackView.addArrangedSubview(idLabel)
        textStackView.addArrangedSubview(textLabel)
        textStackView.addArrangedSubview(typeLabel)
        textStackView.setCustomSpacing(4, after: idLabel)
        self.addSubview(textStackView)
    }
    
    private func setupUI() {
        switch viewType {
        case .cell:
            textLabel.numberOfLines = 2
            textStackView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
            
            dateLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(8)
                make.trailing.equalToSuperview().offset(-16)
            }
        case .normal:
            textLabel.numberOfLines = 0
            textLabel.lineBreakMode = .byWordWrapping
            textStackView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
            
            dateLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(8)
                make.trailing.equalToSuperview().offset(-16)
            }
            break
        }
    }
    
    func setup(with viewModel: TextItemViewModel) {
        idLabel.text = viewModel.idText
        typeLabel.text = viewModel.typeText
        dateLabel.text = viewModel.dateText
        textLabel.text = viewModel.fullText
    }
}
