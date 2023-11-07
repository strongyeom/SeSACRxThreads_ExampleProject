//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
      //  setSearchController()
        title = "\(Int.random(in: 1...100))"
        
        viewModel.items
            .bind(to: viewModel.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .green
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        print("123")
                        owner.navigationController?.pushViewController(SearchViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func setSearchController() {
        view.addSubview(viewModel.searchBar)
        self.navigationItem.titleView = viewModel.searchBar
    }

    
    private func configure() {
        view.addSubview(viewModel.tableView)
        viewModel.tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
