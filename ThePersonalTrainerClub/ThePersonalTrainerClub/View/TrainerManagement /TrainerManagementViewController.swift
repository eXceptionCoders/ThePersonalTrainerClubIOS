//
//  TrainerManagementViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TrainerManagementViewController: BaseViewController, TrainerManagementContract.View {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var trainerTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var lessonsLabel: UILabel!
    @IBOutlet weak var sportsView: UIView!
    @IBOutlet weak var whereView: UIView!
    @IBOutlet weak var lessonsView: UIView!
    
    lazy var presenter: TrainerManagementContract.Presenter = TrainerManagementViewPresenter(
        view: self,
        trainerManagementUseCase: TrainerManagementUseCase(
            userProvider: UserProvider(webService: WebService()),
            classProvider: ClassProvider(webService: WebService())
        )
    )
    
    override func localizeView() {
        trainerTitleLabel.text = NSLocalizedString("trainer_management_trainer_label", comment: "")
        sportsLabel.text = NSLocalizedString("trainer_management_sports_label", comment: "")
        whereLabel.text = NSLocalizedString("trainer_management_locations_label", comment: "")
        lessonsLabel.text = NSLocalizedString("trainer_management_lessons_label", comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("trainer_management_title", comment: "")
        self.tabBarController?.tabBar.isHidden = false
        
        userNameLabel.text = "\(UserSettings.user?.name ?? NSLocalizedString("trainer_management_name_unknown_first_text", comment: "")) \(UserSettings.user?.lastName ?? NSLocalizedString("trainer_management_name_unknown_second_text", comment: ""))"
        
        let activityView = setupActivitiesView()
        let locationView = setupLocationsView()
        
        activityView.items = UserSettings.user?.activities ?? []
        locationView.items = UserSettings.user?.locations ?? []
        refreshLocationsHeight()
        
        addRightButtons([.RightButtonTypeLocation, .RightButtonTypeSport], action: #selector(navigationButtonTapped(sender:)))
    }
    
    @objc func navigationButtonTapped(sender: UIButton) {
        switch sender.tag {
        case RightButtonType.RightButtonTypeLocation.hashValue:
            presenter.onAddLocationTapped()
        case RightButtonType.RightButtonTypeSport.hashValue:
            presenter.onAddSportTapped()
        default:
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLocationsLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            self.refreshLocationsLayout()
        })
    }
    
    override func showLoading() {
        // activityIndicator.startAnimating()
    }
    
    override func hideLoading() {
        // activityIndicator.stopAnimating()
    }
    
    func setTrainer(_ trainer: UserModel) {
        // TODO
    }
    
    func setClasses(_ classes: [ClassModel]) {
        // TODO
    }
}

extension TrainerManagementViewController {
    func setupActivitiesView() -> ActivityStripView {
        let collectionView = ActivityStripView.instantiate()
        collectionView.allowSelection(false)
        
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
    
    func setupLocationsView() -> LocationStripView {
        let collectionView = LocationStripView.instantiate()
        collectionView.allowSelection(false)
        
        whereView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["locationsView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[locationsView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[locationsView]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: whereView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: whereView, attribute: .height, multiplier: 1, constant: 0))
        
        whereView.addConstraints(constraints)
        
        return collectionView
    }
    
    func refreshLocationsHeight() {
        let filteredConstraints = whereView.constraints.filter { $0.identifier == "locationsHeightConstraint" }
        if let constraint = filteredConstraints.first {
            constraint.constant = CGFloat((UserSettings.user?.locations ?? []).count * 40 + 8)
        }
    }
    
    func refreshLocationsLayout() {
        (self.whereView.subviews.first as! LocationStripView).invalidateLayout()
    }
}
