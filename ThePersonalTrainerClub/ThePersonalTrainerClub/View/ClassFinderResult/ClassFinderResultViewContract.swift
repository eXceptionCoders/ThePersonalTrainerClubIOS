//
//  ClassFinderResultViewContract.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import Foundation

enum ClassFinderResultContract {
    typealias View = ClassFinderResultView
    typealias Presenter = ClassFinderResultPresenter
    typealias Navigator = ClassFinderResultNavigator
}

protocol ClassFinderResultView: BaseContract.View {
    func setClasses(_ classes: [ClassModel], _ total: Int)
}

protocol ClassFinderResultPresenter: BaseContract.Presenter {
    func fetchClasses(_ query: ClassFinderQuery)
    func onClassTapped(_ data: ClassModel)
    func book(_ classId: String)
}

protocol ClassFinderResultNavigator: BaseContract.Navigator {
    func popBack()
    func navigateToClassDetail(model: ClassModel)
}
