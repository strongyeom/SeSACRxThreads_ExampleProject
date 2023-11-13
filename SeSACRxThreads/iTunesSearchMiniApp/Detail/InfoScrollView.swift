//
//  InfoScrollView.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/13.
//

import UIKit

class InfoScrollView : UIView {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let upperLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let underLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    // MARK: - 상단
    let infomationFirstLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        view.textColor = .lightGray
        view.infomationLabel(text: " ~ 만개의 평가")
        return view
    }()
    
    let infomationFirstAgeLabel = {
       let view = UILabel()
        view.infomationLabel(text: "연령")
        return view
    }()
    
    let infomationFirstChartLabel = {
       let view = UILabel()
        view.infomationLabel(text: "차트")
        return view
    }()
    
    let infomationFirstDeveloperLabel = {
       let view = UILabel()
        view.infomationLabel(text: "개발자")
        return view
    }()
    
    let infomationFirstLanguageLabel = {
       let view = UILabel()
        view.infomationLabel(text: "언어")
        return view
    }()
    
    
    
    // MARK: - 중단
    let infoResultStarLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    let infoResultAgeLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    let infoResultChartLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    let infoResultDeveloperLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    let infoResultLanguageLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    
    
    // MARK: - 하단
    let infomationDescriptionStarRateLabel = {
       let view = UILabel()
        view.infomationLabel(text: "5개")
        return view
    }()
    
    let infomationDescriptionAgeLabel = {
       let view = UILabel()
        view.infomationLabel(text: "세")
        return view
    }()
    
    let infomationDescriptionChartLabel = {
       let view = UILabel()
        view.infomationLabel(text: "소셜 네트워킹")
        return view
    }()
    
    let infomationDescriptionDeveloperLabel = {
       let view = UILabel()
        view.infomationLabel(text: "카카오톡")
        return view
    }()
    
    let infomationDescriptionLangCountLabel = {
       let view = UILabel()
        view.infomationLabel(text: "+14개")
        return view
    }()
    
    lazy var firstStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstLabel, infoResultStarLabel, infomationDescriptionStarRateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var secondStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstAgeLabel, infoResultAgeLabel, infomationDescriptionAgeLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var thirdStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstChartLabel, infoResultChartLabel, infomationDescriptionChartLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var fourthStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstDeveloperLabel, infoResultDeveloperLabel, infomationDescriptionDeveloperLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var fifthStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstLanguageLabel, infoResultLanguageLabel, infomationDescriptionLangCountLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    func configure() {
        
        self.addSubview(scrollView)
    
//        [upperLine, underLine, firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView].forEach {
//            contentView.addSubview($0)
//        }
        scrollView.addSubview(contentView)
        self.addSubview(upperLine)
    }
    
    func setConstraints() {
        upperLine.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
//
//        upperLine.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().inset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        firstStackView.snp.makeConstraints { make in
//            make.top.equalTo(upperLine.snp.bottom).offset(10)
//            make.leading.equalToSuperview().inset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        secondStackView.snp.makeConstraints { make in
//            make.top.equalTo(firstStackView)
//            make.leading.equalTo(firstStackView.snp.trailing).offset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        thirdStackView.snp.makeConstraints { make in
//            make.top.equalTo(firstStackView)
//            make.leading.equalTo(secondStackView.snp.trailing).offset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        fourthStackView.snp.makeConstraints { make in
//            make.top.equalTo(firstStackView)
//            make.leading.equalTo(thirdStackView.snp.trailing).offset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        fifthStackView.snp.makeConstraints { make in
//            make.top.equalTo(firstStackView)
//            make.leading.equalTo(fourthStackView.snp.trailing).offset(10)
//            make.bottom.equalTo(underLine.snp.top).offset(10)
//        }
//
//        underLine.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview().inset(10)
//            make.bottom.equalToSuperview()
//        }
//
//        upperLine.snp.makeConstraints { make in
//            make.height.equalTo(1)
//        }
//
//        underLine.snp.makeConstraints { make in
//            make.height.equalTo(1)
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
