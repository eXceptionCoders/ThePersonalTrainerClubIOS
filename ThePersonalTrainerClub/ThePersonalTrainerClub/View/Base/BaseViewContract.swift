//
//  BaseViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 07/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum BaseContract {
    typealias View = BaseView
    typealias Presenter = BasePresenter
    typealias Navigator = BaseNavigator
}

protocol BaseView {
    func showLoading()
    func hideLoading()
}

extension BaseView {
    func showLoading() {}
    func hideLoading() {}
}

protocol BasePresenter {}

protocol BaseNavigator {}
