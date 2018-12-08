//
//  TrainerManagementViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TrainerManagementViewController: BaseViewController, TrainerManagementContract.View, LocationStripViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var thumbnailView: UIImageView!
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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let operationQueue = OperationQueue()
    
    private lazy var activityView: ActivityStripView = setupActivitiesView()
    private lazy var locationView: LocationStripView = setupLocationsView()
    private lazy var classesView: ClassStripView = setupLessonsView()
    
    // MARK: - Presenter
    
    lazy var presenter: TrainerManagementContract.Presenter = TrainerManagementViewPresenter(
        view: self,
        trainerManagementUseCase: TrainerManagementUseCase(
            userProvider: UserProvider(webService: WebService()),
            classProvider: ClassProvider(webService: WebService())
        ),
        removeLocationUseCase: RemoveLocationUseCase(locationProvider: LocationProvider(webService: WebService()))
    )
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        if (UserSettings.user?.coach ?? false) && UserSettings.showCoachView {
            //Trainer
            title = NSLocalizedString("trainer_management_title", comment: "")

            trainerTitleLabel.text = NSLocalizedString("trainer_management_trainer_label", comment: "")
            sportsLabel.text = NSLocalizedString("trainer_management_sports_label", comment: "")
            whereLabel.text = NSLocalizedString("trainer_management_locations_label", comment: "")
            lessonsLabel.text = NSLocalizedString("trainer_management_lessons_label", comment: "")
        } else {
            //Athlete
            title = NSLocalizedString("athlete_management_title", comment: "")
            
            trainerTitleLabel.text = NSLocalizedString("athlete_management_trainer_label", comment: "")
            sportsLabel.text = NSLocalizedString("athlete_management_sports_label", comment: "")
            whereLabel.text = NSLocalizedString("athlete_management_locations_label", comment: "")
            lessonsLabel.text = NSLocalizedString("athlete_management_lessons_label", comment: "")
        }
    }
    
    override func showLoading() {
        activityIndicator.startAnimating()
    }
    
    override func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false

        if (UserSettings.user != nil) {
            setUser(UserSettings.user!)
        }

        thumbnailView.setupAsUserThumbnail()
        
        addRightButtons([.RightButtonTypeLocation, .RightButtonTypeSport], action: #selector(navigationButtonTapped(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.fetchUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLocationsLayout()
        refreshLessonsLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            self.refreshLocationsLayout()
            self.refreshLessonsLayout()
        })
    }
    
    // MARK: - TrainerManagementContract.View methods
    
    func setUser(_ user: UserModel) {
        userNameLabel.text = "\(user.name) \(user.lastName)"
        
        activityView.items = user.activities
        locationView.items = user.locations
        
        refreshLocationsHeight()
        
        if !user.thumbnail.isEmpty {
            let downloadOperation = ImageDownloader(urlString: user.thumbnail, indexPath: nil) { success, indexPath, image, error in
                
                if (!success) {
                    return
                }
                
                DispatchQueue.main.async {
                    self.thumbnailView.image = image
                }
            }
            operationQueue.addOperation( downloadOperation )
        }
    }
    
    func setClasses(_ classes: [ClassModel]) {
        classesView.items = classes
        refreshLessonsHeight(count: classes.count)
        refreshLessonsLayout()
    }
    
    // MARK: - Actions
    
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
    
    // MARK: - LocationStripViewDelegate methods
    
    func onLocationTapped(_ model: LocationModel) {
        let alertController = UIAlertController(title: NSLocalizedString("remove_location_title", comment: ""), message: NSLocalizedString(String(format: NSLocalizedString("remove_location_message", comment: ""), model.description), comment: ""), preferredStyle: .alert)
        let removeAction = UIAlertAction(title: NSLocalizedString("remove_button_title", comment: ""), style: .destructive) { (_) in
            self.presenter.onLocationTapped(location: model)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel_button_title", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
        collectionView.allowSelection = false
        collectionView.delegate = self
        
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
        guard let wrapper = self.whereView else {
            return
        }
        
        guard let stripView = wrapper.subviews.first else {
            return
        }
        
        (stripView as! LocationStripView).invalidateLayout()
    }
    
    func setupLessonsView() -> ClassStripView {
        let collectionView = ClassStripView.instantiate()
        collectionView.allowSelection(false)
        
        lessonsView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["classView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[classView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[classView]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: lessonsView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: lessonsView, attribute: .height, multiplier: 1, constant: 0))
        
        lessonsView.addConstraints(constraints)
        
        return collectionView
    }
    
    func refreshLessonsHeight(count: Int) {
        let filteredConstraints = lessonsView.constraints.filter { $0.identifier == "classHeightConstraint" }
        if let constraint = filteredConstraints.first {
            constraint.constant = CGFloat(count * 185 + 8)
        }
    }
    
    func refreshLessonsLayout() {
        guard let wrapper = self.lessonsView else {
            return
        }
        
        guard let stripView = wrapper.subviews.first else {
            return
        }
        
        (stripView as! ClassStripView).invalidateLayout()
    }
}
