//
//  ListView.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/30/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ListView: UIView {
    private var tabBarView: TabBarView!
    private var tableView: UITableView!
    
    var onTabTapped: ( (String) -> Void )? {
        didSet {
            tabBarView.onTabTapped = onTabTapped
        }
    }
    var onSelectedItem: ( (Int) -> Void )?
    var onPullToRefresh: ( () -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        tabBarView = TabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tabBarView)
        
        tableView = UITableView(frame: self.frame, style: .plain)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tabBarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(tabBarView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setup(with viewModel: ListViewModel) {
        tabBarView.setup(with: viewModel.filters)
        if let filterIndex = viewModel.selectedFilterIndex {
            tabBarView.selectTab(at: filterIndex)
        }
        tableView.dataSource = viewModel
        refreshList()
    }
    
    func refreshList() {
        tableView.reloadData()
    }
    
    func showLoading() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideLoading() {
        tableView.refreshControl?.endRefreshing()
    }
    
    @objc private func pullToRefresh() {
        onPullToRefresh?()
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectedItem?(indexPath.row)
    }
}
