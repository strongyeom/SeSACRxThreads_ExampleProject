//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let titleLabel = TitleLabel(inputText: "닉네임은 2글자에서 6글자 미만이 입니다.", inputTextColor: .red)
    
    let viewModel = NickNameViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

    }
    
    func bind() {
        
        viewModel.inputText
            .bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.buttonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.titleLabelHidden
            .bind(to: titleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.text.orEmpty
            .subscribe(with: self) { owner, value in
                owner.viewModel.inputText.onNext(value)
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
        view.addSubview(titleLabel)
        
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(nextButton)
        }
    }

}
