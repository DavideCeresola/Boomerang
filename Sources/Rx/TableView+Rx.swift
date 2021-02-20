//
//  CollectionView+Rx.swift
//  RxBoomerang
//
//  Created by Stefano Mondino on 01/11/2019.
//  Copyright © 2019 Synesthesia. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
#if !COCOAPODS
import Boomerang
#endif

public extension Reactive where Base: UITableView {

    func reloaded(by viewModel: RxListViewModel,
                  dataSource tableViewDataSource: TableViewDataSource) -> Disposable {
        let data = RxTableViewSectionedReloadDataSource<SectionModel<Section, ViewModel>> { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            tableViewDataSource.tableView(tableView, cellForRowAt: indexPath)
        } canEditRowAtIndexPath: { (dataSource, indexPath) -> Bool in
            tableViewDataSource.tableView(base, canEditRowAt: indexPath)
        } canMoveRowAtIndexPath:  { (dataSource, indexPath) -> Bool in
            tableViewDataSource.tableView(base, canMoveRowAt: indexPath)
        }

        return viewModel.sectionsRelay
            .asDriver()
            .map { $0.map { SectionModel(model: $0, items: $0.items) }}
            .drive(items(dataSource: data))
    }

    func animated(by viewModel: RxListViewModel,
                  dataSource tableViewDataSource: TableViewDataSource) -> Disposable {

        let data = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<Section, UniqueViewModelWrapper>>{ (dataSource, tableView, indexPath, item) -> UITableViewCell in
            tableViewDataSource.tableView(tableView, cellForRowAt: indexPath)
        } canEditRowAtIndexPath: { (dataSource, indexPath) -> Bool in
            tableViewDataSource.tableView(base, canEditRowAt: indexPath)
        } canMoveRowAtIndexPath:  { (dataSource, indexPath) -> Bool in
            tableViewDataSource.tableView(base, canMoveRowAt: indexPath)
        }
       
        return viewModel.sectionsRelay
            .asDriver()
            .map { $0
                .map { AnimatableSectionModel(model: $0, items: $0.items.map { UniqueViewModelWrapper(viewModel: $0)}) }
        }
            .drive(items(dataSource: data))
    }

}
#endif
