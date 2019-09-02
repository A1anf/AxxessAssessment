//
//  ListViewController.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    private var listView: ListView!
    private let listService = ListService()
    
    var viewModel: ListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.onSelectedFilterChange = onFilterChange
            viewModel.onViewRequestedForListDetailViewModel = viewForListDetailViewModel
            listView.setup(with: viewModel)
        }
    }
    
    lazy var onFilterChange: ( (String) -> Void ) = { [weak self] (filter) in
        self?.listView.refreshList()
    }
    
    lazy var viewForListDetailViewModel: ( (ListDetailViewModel?) -> UIView? ) = { (viewModel) -> UIView? in
        guard let viewModel = viewModel else {
            return nil
        }
        
        switch viewModel {
        case .image(let imageItemViewModel):
            let imageView = ImageItemView()
            imageView.viewType = .cell
            imageView.setup(with: imageItemViewModel)
            return imageView
        case .text(let textItemViewModel):
            let textView = TextItemView()
            textView.viewType = .cell
            textView.setup(with: textItemViewModel)
            return textView
        case .other(let textItemViewModel):
            let textView = TextItemView()
            textView.viewType = .cell
            textView.setup(with: textItemViewModel)
            return textView
        }
    }
    
    override func loadView() {
        let baseView = UIView()
        baseView.backgroundColor = .white
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarUI()
        setupListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    private func setupNavigationBarUI() {
        title = Constants.Text.listControllerTitle
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupListView() {
        if listView == nil {
            listView = ListView()
            
            listView.onTabTapped = { [weak self] (title) in
                self?.viewModel?.selectedFilter = title
            }
            
            listView.onSelectedItem = { [weak self] (index) in
                guard let detailViewModel = self?.viewModel?.filteredListItemViewModel(at: index) else {
                    self?.displayItemError()
                    return
                }
                self?.showListDetailController(viewModel: detailViewModel)
            }
            
            listView.onPullToRefresh = { [weak self] in
                self?.fetch()
            }
        }
        
        self.view.addSubview(listView)
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func showListDetailController(viewModel: ListDetailViewModel) {
        let detailViewController = ListDetailViewController()
        detailViewController.modalPresentationStyle = .overFullScreen
        detailViewController.modalTransitionStyle = .crossDissolve
        detailViewController.viewModel = viewModel
        self.present(detailViewController, animated: true, completion: nil)
    }
    
    private func fetch() {
        listView.showLoading()
        listService.getList { [weak self] (result) in
            self?.listView.hideLoading()
            switch result {
            case .success(let newViewModel):
                if let currentViewModel = self?.viewModel {
                    newViewModel.selectedFilter = currentViewModel.selectedFilter
                }
                self?.viewModel = newViewModel
            case .failure(let error):
                self?.displayFetchError(error)
                break
            }
        }
    }
    
    private func displayFetchError(_ error: Error) {
        let title = Constants.ErrorMessages.standardTitle
        let message = Constants.ErrorMessages.standardTryAgain
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Text.cancelButtonTitle, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.Text.acceptButtonTitle, style: .default, handler: { [weak self] (action) in
            self?.fetch()
        }))
        
        self.present(alert, animated: true, completion: { [weak self] in
            self?.listView.hideLoading()
        })
    }
    
    private func displayItemError() {
        let title = Constants.ErrorMessages.standardTitle
        let message = Constants.ErrorMessages.itemCannotBeDisplayed
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Text.standardButtonTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
