//
//  MovieCell.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/06.
//

import UIKit

class MovieCell : UITableViewCell {
    
    static let identifier  = "MovieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    let moviename = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17, weight: .black)
        view.textAlignment = .center
        return view
    }()
    
    let openDate = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(moviename)
        contentView.addSubview(openDate)
    }
    
    func setConstraints() {
        moviename.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
        }
        
        openDate.snp.makeConstraints { make in
            make.top.equalTo(moviename.snp.bottom).offset(10)
            make.leading.equalTo(moviename)
        }
    }
    
    
    
}
