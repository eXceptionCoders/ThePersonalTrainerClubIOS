//
//  AddSportViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class AddSportViewController: BaseViewController, AddSportContract.View {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sportsView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Presenter
    
    lazy var presenter: AddSportContract.Presenter = AddSportViewPresenter(view: self,
                                                                           activityUseCase: ActivityUseCase(activityProvider: ActivityProvider(webService: WebService())),
                                                                           setActivitiesUseCase: SetActivityUseCase(activityProvider: SetActivitiesProvider(webService: WebService()), userProvider: UserProvider(webService: WebService())))
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.create()
        
        addDoneButton(action: #selector(doneButtonTapped(sender:)))
    }
    
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        title = NSLocalizedString("add_sport_title", comment: "")
    }
    
    override func showLoading() {
        sportsView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    override func hideLoading() {
        sportsView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Actions
    
    @objc func doneButtonTapped(sender: UIButton) {
        let selectedSports = (sportsView.subviews.first as! ActivityStripView).indexPathsForSelectedItems
        presenter.saveSports(indexPaths: selectedSports)
    }
    
    // MARK: - AddSportContract.View Methods
    
    func showError() {
        showAlertMessage(title: nil, message: NSLocalizedString("add_sport_error", comment: ""))
    }
    
    func showSports(sports: [ActivityModel]) {
        let activityView = setupActivitiesView()
        activityView.items = sports
        
        refreshActivitiesHeight(itemsCount: sports.count)
    }
    
    // MARK: - Helpers
    
    private func setupActivitiesView() -> ActivityStripView {
        let collectionView = ActivityStripView.instantiate()
        collectionView.allowsMultipleSelection(true)
        collectionView.setSelectedItems(items: UserSettings.user?.activities ?? [])
        
        sportsView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["activitiesView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[activitiesView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[activitiesView]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: sportsView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: sportsView, attribute: .height, multiplier: 1, constant: 0))
        
        sportsView.addConstraints(constraints)
        
        return collectionView
    }
    
    private func refreshActivitiesHeight(itemsCount: Int) {
        let filteredConstraints = sportsView.constraints.filter { $0.identifier == "activitiesHeightConstraint" }
        if let constraint = filteredConstraints.first {
            let w = Int(sportsView.bounds.width/60)
            let r = Int(itemsCount/w)+1
            
            constraint.constant = CGFloat(r * 84 + 8)
        }
    }
}
