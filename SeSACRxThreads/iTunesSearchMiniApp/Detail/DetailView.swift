//
//  DetailView.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/07.
//

import UIKit
import Kingfisher

class DetailView : UIView {
    
    let contentView = {
        let view = UIView()
        return view
    }()
    
    let verticalScrollView = UIScrollView()
    let horizantalScrollView = UIScrollView()
    
    let iconImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.cornerCurve = .continuous
        image.clipsToBounds = true
        return image
    }()
    
    let appname = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .black)
        view.numberOfLines = 0
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    let appDeveloper = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 11)
        view.textColor = .lightGray
        return view
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("열기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [appname, appDeveloper, downloadButton])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    let newRelease = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.text = "새로운 기능"
        return view
    }()
    
    let newReleaseVersion = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 11)
        view.textColor = .lightGray
        return view
    }()
    
    let realseNote = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    let descriptionLabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        view.numberOfLines = 0
        return view
    }()
    
    
    // MARK: - InfoView
    //lazy var infoView = InfoScrollView()
    
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
    
    let betweenFirstLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let betweenSecondLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let betweenThirdLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let betweenFourthLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let horizantalView = {
       let view = UIView()
        return view
    }()
 
    // MARK: - 상단
    let infomationFirstRateLabel = {
       let view = UILabel()
        view.infomationLabel(text: " ~ 만개의 평가")
        return view
    }()
    
    let infoResultStarLabel = {
       let view = UILabel()
        view.text = "임시"
        view.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        view.textColor = .lightGray
        return view
    }()
    
    let infomationDescriptionStarRateLabel = {
       let view = UILabel()
        view.infomationLabel(text: "5개")
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
    let infoResultAgeLabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        view.textColor = .lightGray
//        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    let infoResultChartLabel = {
       let view = UILabel()
        view.text = "#\(Int.random(in: 1...29))"
        view.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        view.textColor = .lightGray
//        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()

    let infoResultDeveloperImage = {
       let view = UIImageView()
        view.image = UIImage(systemName: "person.crop.square")
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    let infoResultLanguageLabel = {
       let view = UILabel()
        view.text = "임시"
        view.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        view.textColor = .lightGray
//        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    
    
    // MARK: - 하단

    
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
    
    
    lazy var firstInfoStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstRateLabel, infoResultStarLabel, infomationDescriptionStarRateLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var secondStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstAgeLabel, infoResultAgeLabel, infomationDescriptionAgeLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var thirdStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstChartLabel, infoResultChartLabel, infomationDescriptionChartLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var fourthStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstDeveloperLabel, infoResultDeveloperImage, infomationDescriptionDeveloperLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var fifthStackView = {
        let stack = UIStackView(arrangedSubviews: [infomationFirstLanguageLabel, infoResultLanguageLabel, infomationDescriptionLangCountLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
        horizantalScrollView.showsHorizontalScrollIndicator = false
        horizantalScrollView.showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(verticalScrollView)
        
        [iconImage, stackView, newRelease, newReleaseVersion, realseNote, descriptionLabel, horizantalScrollView].forEach {
            contentView.addSubview($0)
        }
        verticalScrollView.addSubview(contentView)
        horizantalScrollView.addSubview(horizantalView)
        //horizantalView.addSubview(exampleText)
        [upperLine, underLine, betweenFirstLine,betweenFirstLine,betweenSecondLine,betweenThirdLine,betweenFourthLine, firstInfoStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView].forEach {
            horizantalView.addSubview($0)
        }
    }
    
    private func setConstraints() {
        
        verticalScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
           // make.height.equalTo(2000)
        }
        
        iconImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.size.equalTo(120)
        }
        appDeveloper.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(iconImage)
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(62)
        }
        

        
        
        
        // MARK: - InfoView Layout
        horizantalScrollView.snp.makeConstraints { make in
            make.top.equalTo(downloadButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(110)
        }
        
        horizantalView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        upperLine.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }
        
        underLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }
        
        firstInfoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.top.equalTo(upperLine.snp.bottom).inset(5)
            make.bottom.equalTo(underLine.snp.top).inset(-5)
        }
        
        betweenFirstLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(45)
            make.centerY.equalTo(firstInfoStackView)
            make.leading.equalTo(firstInfoStackView.snp.trailing).offset(30)
        }
        
        // secondStackView, thirdStackView, fourthStackView, fifthStackView
        secondStackView.snp.makeConstraints { make in
            make.leading.equalTo(betweenFirstLine.snp.trailing).offset(30)
            make.top.equalTo(upperLine.snp.bottom).inset(5)
            make.bottom.equalTo(underLine.snp.top).inset(-5)
        }
        
        betweenSecondLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(45)
            make.centerY.equalTo(secondStackView)
            make.leading.equalTo(secondStackView.snp.trailing).offset(30)
        }
        
        thirdStackView.snp.makeConstraints { make in
            make.leading.equalTo(betweenSecondLine.snp.trailing).offset(30)
            make.top.equalTo(upperLine.snp.bottom).inset(5)
            make.bottom.equalTo(underLine.snp.top).inset(-5)
        }
        
        betweenThirdLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(45)
            make.centerY.equalTo(thirdStackView)
            make.leading.equalTo(thirdStackView.snp.trailing).offset(30)
        }
        
        infoResultDeveloperImage.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        fourthStackView.snp.makeConstraints { make in
            make.leading.equalTo(betweenThirdLine.snp.trailing).offset(30)
            make.top.equalTo(upperLine.snp.bottom).inset(5)
            make.bottom.equalTo(underLine.snp.top).inset(-5)
        }
        
        betweenFourthLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(45)
            make.centerY.equalTo(fourthStackView)
            make.leading.equalTo(fourthStackView.snp.trailing).offset(30)
        }
        
        fifthStackView.snp.makeConstraints { make in
            make.leading.equalTo(betweenFourthLine.snp.trailing).offset(30)
            make.top.equalTo(upperLine.snp.bottom).inset(5)
            make.bottom.equalTo(underLine.snp.top).inset(-5)
            make.trailing.equalToSuperview().inset(8)
        }
        
        newRelease.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).offset(10)
            make.leading.equalTo(iconImage)
            
        }
        
        newReleaseVersion.snp.makeConstraints { make in
            make.leading.equalTo(newRelease)
            make.top.equalTo(newRelease.snp.bottom).offset(10)
        }
        
        descriptionLabel.backgroundColor = .yellow
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(newReleaseVersion.snp.bottom).offset(15)
            make.leading.equalTo(iconImage)
            make.trailing.equalTo(appname)
        }
        
        realseNote.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    
    }
    
    func setUI(data: AppInfo?) {
        guard let data else { return }
        let url = URL(string: data.artworkUrl512)!
        self.iconImage.kf.setImage(with: url)
        self.appname.text = data.trackName
        self.appDeveloper.text = data.sellerName
        self.newReleaseVersion.text = "버전" + data.version
        self.realseNote.text = data.releaseNotes
        self.descriptionLabel.text = data.description
        
        // 평가
        
        if data.userRatingCount > 10000 {
            let rateCount = "\(data.userRatingCount / 10000)만개의 평가"
            infomationFirstRateLabel.text = rateCount
        } else {
            infomationFirstRateLabel.text = "\(data.userRatingCount.formatted())개의 평가"
        }
        
       
        
        infoResultStarLabel.text = String(format: "%.1f", data.averageUserRating)
//        infomationDescriptionStarRateLabel.text =
        
        // 연령
        infoResultAgeLabel.text = data.trackContentRating
        // 차트
        infomationDescriptionChartLabel.text = data.genres[0]
       
        // 개발자
        infomationDescriptionDeveloperLabel.text = data.sellerName
        // 언어
        infoResultLanguageLabel.text = "KO"
        infomationDescriptionLangCountLabel.text = "+ \(data.languageCodesISO2A.count-1)개 언어"
    }
}
