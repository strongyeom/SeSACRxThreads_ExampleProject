//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
   // let infoText = BehaviorSubject(value: "만 17세 이상만 가입 가능합니다.")
    let viewModel = BirthdayViewModel()
    let bgColor = BehaviorSubject(value: UIColor.blue)
    let disposeBag = DisposeBag()
    
    let currentYear = Calendar.current.component(.year, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        
        viewModel.buttonValidate
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        birthDayPicker.rx.date
            .bind(to: viewModel.birthday)
            .disposed(by: disposeBag)
        
 
        
        bgColor
            .bind(to: infoLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        // 만 17세 validate 처리 하기
        viewModel.year
            .map { self.currentYear - $0 >= 17 }
            .bind { value in
                let age = value ? UIColor.blue : UIColor.red
                self.bgColor.onNext(age)
                self.viewModel.buttonValidate.onNext(value)
            }
            .disposed(by: disposeBag)
        
        viewModel.year
            .map { "\($0)년"}
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.yearLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.month
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.monthLabel.text = "\(value)월"
            }
            .disposed(by: disposeBag)
        
        viewModel.day
            .map { "\($0)일" }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        print("가입완료")
    }

    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
