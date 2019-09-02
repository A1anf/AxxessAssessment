//
//  ImageItemView.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ImageItemView: UIView {
    private var idLabel: UILabel!
    private var typeLabel: UILabel!
    private var dateLabel: UILabel!
    private var imageView: UIImageView!
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
        idLabel.apply(Stylesheet.Component.ImageItemView.idLabel)
        
        typeLabel = UILabel()
        typeLabel.apply(Stylesheet.Component.ImageItemView.typeLabel)
        
        dateLabel = UILabel()
        dateLabel.apply(Stylesheet.Component.ImageItemView.dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        textStackView = UIStackView()
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.axis = .vertical
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        textStackView.addArrangedSubview(idLabel)
        textStackView.addArrangedSubview(typeLabel)
        self.addSubview(textStackView)
    }
    
    private func setupUI() {
        switch viewType {
        case .cell:
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalTo(textStackView.snp.leading).offset(-16)
                make.width.equalTo(90)
                make.height.equalTo(90)
            }
            
            textStackView.snp.makeConstraints { (make) in
                make.leading.equalTo(imageView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(16)
                make.centerY.equalTo(imageView)
            }
            
            dateLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(8)
                make.trailing.equalToSuperview().offset(-16)
            }
        case .normal:
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalTo(textStackView.snp.top).offset(-16)
                make.bottom.equalTo(dateLabel.snp.top).offset(-16)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(imageView.snp.width).multipliedBy(3 / 2)
            }
            
            textStackView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            textStackView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 251), for: .horizontal)
            textStackView.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalTo(dateLabel.snp.leading).offset(-16)
            }
            
            dateLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
            dateLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 252), for: .horizontal)
            dateLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(16)
                make.leading.equalTo(textStackView.snp.trailing).offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
        }
    }
    
    func setup(with viewModel: ImageItemViewModel) {
        idLabel.text = viewModel.idText
        typeLabel.text = viewModel.typeText
        dateLabel.text = viewModel.dateText
        
        setupImage(url: viewModel.imageUrl)
    }
    
    func setupImage(url: URL?) {
        guard let url = url else {
            showErrorImage()
            return
        }
        
        ImageManager.shared.retreiveImage(url: url) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(_):
                self?.showErrorImage()
                break
            }
        }
    }
    
    private func showErrorImage() {
        if let brokenImage = UIImage(named: Constants.Images.brokenImage) {
            imageView.image = brokenImage
        }
    }
}
