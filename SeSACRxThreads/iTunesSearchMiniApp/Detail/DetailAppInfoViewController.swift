//
//  DetailAppInfoViewController.swift
//  SeSACRxThreads
//
//  Created by 염성필 on 2023/11/07.
//

import UIKit
import RxSwift

class DetailAppInfoViewController : UIViewController {
    var detailInfo: AppInfo?

    let detailView = DetailView()

    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dump(detailInfo)
        detailView.setUI(data: detailInfo)
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }
}
