//
//  iTunesTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import UIKit
import RxSwift

class ITunesTableViewCell : UITableViewCell {
    
    static let identifier = "iTunesTableViewCell"
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()

    let firstImage = {
       let image = UIImageView()
        image.layer.cornerRadius = 12
        image.backgroundColor = .red
        image.clipsToBounds = true
        return image
    }()
    
    let secondImage = {
       let image = UIImageView()
        image.layer.cornerRadius = 12
        image.backgroundColor = .blue
        image.clipsToBounds = true
        return image
    }()
    
    let thirdImage = {
       let image = UIImageView()
        image.layer.cornerRadius = 12
        image.backgroundColor = .green
        image.clipsToBounds = true
        return image
    }()
    
    lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [firstImage, secondImage, thirdImage])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        [appNameLabel, appIconImageView, downloadButton, stackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        appIconImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.leading.top.equalToSuperview().inset(10)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(appIconImageView)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(10)
            make.leading.equalTo(appIconImageView)
            make.trailing.equalTo(downloadButton)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
