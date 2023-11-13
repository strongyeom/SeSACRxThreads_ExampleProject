//
//  FirstCell.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/08.
//

import UIKit
import SnapKit

class InfoCell : UICollectionViewCell {
    
    let upperLine = UIView()
    let underLine = UIView()
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
    
    lazy var FirstStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstLabel, infoResultStarLabel, infomationDescriptionStarRateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var SecondStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstAgeLabel, infoResultAgeLabel, infomationDescriptionAgeLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var ThirdStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstChartLabel, infoResultChartLabel, infomationDescriptionChartLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var FourthStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstDeveloperLabel, infoResultDeveloperLabel, infomationDescriptionDeveloperLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    lazy var FifThStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstLanguageLabel, infoResultLanguageLabel, infomationDescriptionLangCountLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    func configure() {
        [FirstStackView, SecondStackView, ThirdStackView, FourthStackView, FifThStackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        
    }
}

extension UILabel {
    func infomationLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.textColor = .lightGray
    }
}
