//
//  ShoppingListPartTwoViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/10.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingListPartTwoViewController : UIViewController {
    
    let tableView = {
       let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.backgroundColor = .white
        table.rowHeight = 100
        return table
    }()
    
    var exampleClicked: [AppInfo] = []
    
    let viewModel = ShoppingViewModel()
    let disposeBag = DisposeBag()
    
    let editBarBtn = {
       let button = UIBarButtonItem()
        button.title = "Edit"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
        print(tableView.isEditing)
        print("ShoppingListPartTwoViewController - viewDidLoad")
    }
    
    func bind() {
     
        
        
        let input = ShoppingViewModel.Input(cellTap: tableView.rx.modelSelected(AppInfo.self))
        
        
        
        let output = input
                
        // items 테이블뷰에 뿌려주기
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) {
                row, element, cell in
                cell.appNameLabel.text = element.trackName
                
                cell.editButton.rx.tap
                    .bind(with: self) { owner, _ in
                        print("\(row) 번째 버튼눌림")
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        // Cell 클릭시
        output.cellTap
            .bind(with: self) { owner, result in
                dump(result)
                owner.navigationController?.pushViewController(DetailShoppingListPartViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        let deleteTrigger = PublishRelay<Bool>()
        
        deleteTrigger
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind { owner, bool in
                print(bool)
                owner.tableView.isEditing = bool
//                owner.tableView.setEditing(bool, animated: true)
            }
            .disposed(by: disposeBag)

        // TableViewCell 삭제
        tableView.rx.itemDeleted
            .observe(on: MainScheduler.asyncInstance) // vs MainScheduler.instance - 동작안함
            .bind(with: self) { owner, index in
                print("index - \(index)")
                // TODO: - 왜 여기서는 isEditing 작동하지 않을까?
//                owner.tableView.setEditing(false, animated: true)
//                DispatchQueue.main.async {
//                    owner.tableView.isEditing = false
//                    print(owner.tableView.isEditing)
//                }
//                owner.tableView.isEditing = false
//                print(owner.tableView.isEditing)
                
                owner.viewModel.data.remove(at: index.row)
                owner.viewModel.items.onNext(owner.viewModel.data)
//                deleteTrigger.accept(false)
            
                owner.tableView.setEditing(false, animated: true)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemInserted
            .bind(with: self) { owner, index in
                print("itemInserted - \(index)")
            }
            .disposed(by: disposeBag)
       
        // TableViewCell 자리 이동
        tableView.rx.itemMoved
            .map { $0.destinationIndex.row }
            .bind(with: self) { owner, value in
                print("바꿀려는 인덱스 : \(value)")
                owner.tableView.isEditing.toggle()
                owner.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        // NavigationBarbutton
        navigationItem.rightBarButtonItem = editBarBtn
        
        editBarBtn.rx.tap
            .bind(with: self) { owner, _ in
                owner.tableView.isEditing.toggle()
                
                print("--btn \(owner.tableView.isEditing)")
            }
            .disposed(by: disposeBag)
        
    }
    
    func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
