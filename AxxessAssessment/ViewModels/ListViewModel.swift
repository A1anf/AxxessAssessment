//
//  ListViewModel.swift
//  AxxessAssessment
//
//  Created by Carl Funk on 8/29/19.
//  Copyright © 2019 Carl Funk. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {
    private let model: ListDataModel
    private let allFilter = "all"
    
    var onSelectedFilterChange: ( (String) -> Void )?
    var onViewRequestedForListDetailViewModel: ( (ListDetailViewModel?) -> UIView? )?
    
    var selectedFilter: String {
        didSet {
            if oldValue != selectedFilter {
                onSelectedFilterChange?(selectedFilter)
            }
        }
    }
    
    init(model: ListDataModel) {
        self.model = model
        self.selectedFilter = allFilter
    }
    
    var filters: [String] {
        var filterList = [allFilter]
        for listItem in model {
            let lowercaseListItem = listItem.type.lowercased()
            if !filterList.contains(lowercaseListItem) {
                filterList.append(lowercaseListItem)
            }
        }
        return filterList
    }
    
    var selectedFilterIndex: Int? {
        return filters.firstIndex(of: selectedFilter)
    }
    
    private var filteredListItems: [ListDetailDataModel] {
        return model.filter({ selectedFilter == allFilter ? true : $0.type == selectedFilter })
    }
    
    var filteredListItemViewModels: [ListDetailViewModel] {
        return filteredListItems.compactMap({ return getListItemViewModelForModel($0)
        })
    }
    
    func filteredListItemViewModel(at index: Int) -> ListDetailViewModel? {
        let listItems = filteredListItems
        guard index >= 0 && index < listItems.count else {
            return nil
        }
        
        let listItemData = listItems[index]
        return getListItemViewModelForModel(listItemData)
    }
    
    private func getListItemViewModelForModel(_ listDetailDataModel: ListDetailDataModel) -> ListDetailViewModel? {
        return ListDetailViewModel(model: listDetailDataModel)
    }
}

extension ListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = filteredListItemViewModel(at: indexPath.row)
        
        let cell = ContainerTableViewCell()
        cell.containedView = onViewRequestedForListDetailViewModel?(viewModel)
        return cell
    }
}
