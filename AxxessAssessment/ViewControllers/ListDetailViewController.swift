//
//  ListDetailViewController.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/31/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {
    private var closeButton: UIButton!
    private var scrollView: UIScrollView!
    
    var viewModel: ListDetailViewModel?
    
    override func loadView() {
        let baseView = UIView()
        baseView.backgroundColor = .white
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupFullSizeView()
    }
    
    private func setupViews() {
        closeButton = UIButton()
        closeButton.setImage(UIImage(named: Constants.Images.close), for: .normal)
        closeButton.setTitleColor(UIColor.blue, for: .normal)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeButton)
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(scrollView.snp.top).offset(-20)
            make.width.equalTo(21)
            make.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func setupFullSizeView() {
        guard let viewModel = viewModel else {
            return
        }
        
        var fullSizeView: UIView
        switch viewModel {
        case .image(let imageItemViewModel):
            let imageView = ImageItemView()
            imageView.viewType = .normal
            imageView.setup(with: imageItemViewModel)
            fullSizeView = imageView
        case .text(let textItemViewModel):
            let textView = TextItemView()
            textView.viewType = .normal
            textView.setup(with: textItemViewModel)
            fullSizeView = textView
        case .other(let textItemViewModel):
            let textView = TextItemView()
            textView.viewType = .normal
            textView.setup(with: textItemViewModel)
            fullSizeView = textView
        }
        
        scrollView.addSubview(fullSizeView)
        fullSizeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
