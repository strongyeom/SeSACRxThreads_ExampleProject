//
//  FirstCell.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/08.
//

import UIKit
import SnapKit

class FirstCell : UICollectionViewCell {
    
    static let identifier = "FirstCell"
    let label = {
       let view = UILabel()
        view.text = "임시입니다."
        view.textColor = .red
        view.font = UIFont.systemFont(ofSize: 20, weight: .black)
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
}
