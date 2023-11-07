//
//  TitleLabel.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/01.
//

import UIKit

class TitleLabel: UILabel {
    
    init(inputText: String, inputTextColor: UIColor) {
        super.init(frame: .zero)
        text = inputText
        font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textAlignment = .center
        textColor = inputTextColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
