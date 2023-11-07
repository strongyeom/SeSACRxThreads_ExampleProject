//
//  ValidationViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/08.
//

import UIKit
import RxSwift

class ValidationViewController : UIViewController {
    
    let textField = {
       let view = UITextField()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1
        view.tintColor = .green
        return view
    }()
    
    let validateLabel = {
       let view = UILabel()
        view.text = "Label"
        return view
    }()
    
    let button = {
       let view = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "버튼"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .blue
        view.configuration = config
        return view
    }()
    
    lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [textField, validateLabel, button])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        bind()
    }
    
    let viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    func bind() {
        
        // 텍스트 필드 8글자 이상이면, 레이블 숨기고 버튼 활성화 버튼 핑크색
        // 텍스트 필드 8글자 미만이면, 레이블 보여주고 버튼 비활성화, 버튼 그레이색
        
        let input = ValidationViewModel.Input(text: textField.rx.text.orEmpty, tap: button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        
        output.valideText
            .drive(validateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.text
            .bind(to: validateLabel.rx.isHidden, button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.text
            .bind(with: self) { owner, result in
                let color = result ? UIColor.systemPink : UIColor.gray
                owner.button.backgroundColor = color
            }
            .disposed(by: disposeBag)
            
        output.tap
            .bind(with: self) { owner, _ in
                print("버튼 눌림")
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func configure() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
