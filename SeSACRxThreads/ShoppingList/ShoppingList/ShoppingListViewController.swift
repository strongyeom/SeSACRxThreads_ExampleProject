//
//  ShoppingListViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/05.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class ShoppingListViewController: UIViewController {
    
    
    let tableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.backgroundColor = .white
        table.rowHeight = 80
        table.separatorStyle = .none
        return table
    }()

    var disposeBag = DisposeBag()
    let viewModel = ShoppingListViewModel()
    
    let plusbarButton = {
       let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        return button
    }()
    
    
    var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        bind()
        // setSearchController()
        
    }
    
    func bind() {
        viewModel.items
            /// "Read" 데이터 읽어오기
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) {
            row, element, cell in
                cell.appNameLabel.text = element.trackName
            cell.appIconImageView.backgroundColor = .blue
            
                // cell 안에 있는 버튼에 대한 액션이 필요할때 bind 구문 안에서 메서드 만들어준다.
                /// "받기" 버튼 누르면 삭제 시키기
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        print("\(row)번째 \(element) 요소 버튼 눌림")
                        //owner.data.remove(at: row)
                        owner.viewModel.items.onNext(owner.viewModel.data) // 해당 데이터 전체를 업데이트 시키는데 삭제한 것만 업데이트 시키는 방법은 없을까? 마치 reloadRowAt 처럼
                    }
                    .disposed(by: cell.disposeBag)
                
                
                /// "편집" 버튼 누르면 Cell에 데이터 전달
                cell.editButton.rx.tap
                    .withLatestFrom(self.textField.rx.text.orEmpty)
                    .subscribe(with: self, onNext: { owner, text in
                        print("편집 버튼 눌렸을때 TextField의 text : \(text)")
                        
                        let alert = UIAlertController(title: "타이틀입니다.", message: "내용입니다.", preferredStyle: .alert)
                        alert.addTextField { textField in
                            textField.text = cell.appNameLabel.text
                        }
                        let ok = UIAlertAction(title: "확인", style: .default) { _ in
                            cell.appNameLabel.text = alert.textFields?[0].text
                            // 삭제할때 onNext에 다시 data를 넣어주는데, textField에서 작성한 내용을 data의 해당 row에 할당 시켜서 reload 되도 데이터가 유지 될 수 있도록 설정
                           // owner.data[row].trackName = alert.textFields?[0].text ?? ""
                        }
                        let cancel = UIAlertAction(title: "취소", style: .cancel)
                       
                        alert.addAction(ok)
                        alert.addAction(cancel)
                        owner.present(alert, animated: true)
                    })
                    .disposed(by: cell.disposeBag)
            
        }
        .disposed(by: disposeBag)

        viewModel.request
            .map { "\($0.results.count)개 데이터" }
            .drive(with: self) { owner, value in
                owner.navigationItem.title = value
            }
            .disposed(by: disposeBag)
        
        
        
        
        /// + 버튼 누르면 테이블 cell 추가
//        plusbarButton.rx.tap
//            .subscribe(with: self) { owner, _ in
//                let randomAddElement = ["첫번째", "두번째", "세번째", "네번째"].randomElement()!
//
//
////                print("+ 버튼 눌림  추가 되는 요소 : \(randomAddElement)")
//                owner.data.insert(randomAddElement, at: 0)
//                owner.items.onNext(owner.data)
//            } onDisposed: { _ in
//                print("onDisposed")
//            }
//            .disposed(by: disposeBag)
//
//
       
    }
    
    
    
    
    
    func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
