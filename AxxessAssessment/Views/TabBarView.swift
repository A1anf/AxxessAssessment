//
//  TabBarView.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/30/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    private var scrollView: UIScrollView!
    private var scrollViewContentView: UIView!
    private var stackView: UIStackView!
    private var selectedBarView: UIView!
    private var selectedBarOuterView: UIView!
    private var bottomLineView: UIView!
    
    private var selectedBarViewHeight = 5
    private var bottomLineViewHeight = 1
    
    var onTabTapped: ( (String) -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        
        scrollViewContentView = UIView()
        scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(scrollViewContentView)
        
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollViewContentView.addSubview(stackView)
        
        let placeholderView = UIView()
        placeholderView.snp.makeConstraints { (make) in
            make.width.equalTo(0)
        }
        stackView.addArrangedSubview(placeholderView)
        
        selectedBarOuterView = UIView()
        selectedBarOuterView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollViewContentView.addSubview(selectedBarOuterView)
        
        selectedBarView = UIView()
        selectedBarView.apply(Stylesheet.Component.TabBarView.selectedBarView)
        selectedBarView.translatesAutoresizingMaskIntoConstraints = false
        self.selectedBarOuterView.addSubview(selectedBarView)
        
        bottomLineView = UIView()
        bottomLineView.apply(Stylesheet.Component.TabBarView.bottomLineView)
        self.addSubview(bottomLineView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(bottomLineView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(bottomLineViewHeight)
        }
        
        scrollViewContentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(selectedBarOuterView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        selectedBarOuterView.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(selectedBarViewHeight)
        }
        
        selectedBarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(selectedBarViewHeight)
        }
    }
    
    func setup(with titles: [String]) {
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        var hasSetupSelectedBar = false
        for title in titles {
            let tabView = createTabView(title: title)
            stackView.addArrangedSubview(tabView)
            
            if !hasSetupSelectedBar {
                hasSetupSelectedBar = true
                selectedBarView.snp.makeConstraints { (make) in
                    make.width.equalTo(tabView.snp.width)
                }
            }
        }
    }
    
    private func createTabView(title: String) -> TabView {
        let tabView = TabView()
        tabView.onTapped = { [weak self] (tappedTabView, title) in
            self?.animateSelectedBar(to: tappedTabView)
            self?.onTabTapped?(title)
        }
        tabView.setup(with: title)
        return tabView
    }
    
    private func animateSelectedBar(to tabView: TabView) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.selectedBarView.frame = tabView.frame
        }
    }
    
    func selectTab(at index: Int) {
        guard index >= 0 && index < stackView.arrangedSubviews.count else {
            return
        }
        
        guard let tabView = stackView.arrangedSubviews[index] as? TabView else {
            return
        }
        
        selectedBarView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(tabView.snp.leading)
            make.height.equalTo(selectedBarViewHeight)
            make.width.equalTo(tabView.snp.width)
        }
    }
}
