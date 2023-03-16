//
//  ContainerView.swift
//  Sofascore
//
//  Created by Akademija on 15.03.2023..
//

import UIKit

class ContainerView: BaseView {

    override func addViews() {
    }

    override func styleViews() {
        backgroundColor = .red
    }

    override func setupConstraints() {
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
    }

}
