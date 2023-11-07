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
    
    let scrollView = UIScrollView()
    
    let iconImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    let appname = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .black)
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
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
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
        view.text = "새로운 시작"
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(scrollView)
        [iconImage, stackView, newRelease, newReleaseVersion, realseNote, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        scrollView.addSubview(contentView)
    }
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(2000)
        }
        
        iconImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.size.equalTo(100)
        }
        appDeveloper.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(iconImage)
            make.leading.equalTo(iconImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
        
        newRelease.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(10)
            make.leading.equalTo(iconImage)
        }
        
        newReleaseVersion.snp.makeConstraints { make in
            make.leading.equalTo(newRelease)
            make.top.equalTo(newRelease.snp.bottom).offset(10)
        }
        
        realseNote.snp.makeConstraints { make in
            make.top.equalTo(newReleaseVersion.snp.bottom).offset(15)
            make.leading.equalTo(iconImage)
            make.trailing.equalTo(appname)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(realseNote.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
            
        }
        
        
    }
    
    func setUI(data: AppInfo?) {
        guard let data else { return }
        let url = URL(string: data.artworkUrl512)!
        self.iconImage.kf.setImage(with: url)
        self.appname.text = data.trackName
        self.appDeveloper.text = data.sellerName
        self.newReleaseVersion.text = data.version
        self.realseNote.text = data.releaseNotes
        self.descriptionLabel.text = data.description
    }
}
