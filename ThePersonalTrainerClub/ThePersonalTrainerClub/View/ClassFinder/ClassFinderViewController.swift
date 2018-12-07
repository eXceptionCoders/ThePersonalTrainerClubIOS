//
//  ClassFinderViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

enum ClassFinderViewControllerKeys: String {
    case LastQuery
}

class ClassFinderViewController: BaseViewController, ClassFinderContract.View {
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityStripView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationStripView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceRangeSliderView: UIView!
    @IBOutlet weak var searchButton: DefaultButton!
    
    // MARK: - Properties
    
    let priceRangeSlider = RangeSlider(frame: CGRect.zero)
    var activityView: ActivityStripView!
    var locationView: LocationStripView!
    
    // MARK: - Presenter
    
    lazy var presenter: ClassFinderContract.Presenter = ClassFinderViewPresenter(view: self)
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPriceRange()
        setupPriceRangeSliderView()
        
        localizeView()
        
        activityView = setupActivitiesView()
        locationView = setupLocationsView()
        
        priceRangeSlider.addTarget(self, action: #selector(ClassFinderViewController.priceRangeSliderValueChanged(_:)), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshLocationsLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        priceRangeSlider.frame = CGRect(x: 0, y: 0, width: priceRangeSliderView.bounds.width, height: 40.0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            self.refreshLocationsLayout()
        })
    }
    
    // MARK: - BaseViewController methods
    
    override func localizeView() {
        title = NSLocalizedString("class_finder_title", comment: "")
        
        activityLabel.text = NSLocalizedString("class_finder_activity_label", comment: "")
        locationLabel.text = NSLocalizedString("class_finder_location_label", comment: "")
        distanceLabel.text = String(format: NSLocalizedString("class_finder_distance_label", comment: ""), roundf( distanceSlider.value ))
        priceLabel.text = String(format: NSLocalizedString("class_finder_price_label", comment: ""), getPriceLabel())
        searchButton.setTitle(NSLocalizedString("class_finder_search_button", comment: ""), for: .normal)
    }
    
    // MARK: - ClassFinderContract.View methods
    
    func setUser(_ user: UserModel) {
        activityView.items = user.activities
        locationView.items = user.locations
        resetInputs()
        restoreLastQuery()
        refreshLocationsHeight()
    }
    
    // MARK: - Helpers
    
    func getPriceLabel() -> String {
        if priceRangeSlider.lowerValue == priceRangeSlider.minimumValue && priceRangeSlider.upperValue == priceRangeSlider.maximumValue {
            return NSLocalizedString("class_finder_any_label", comment: "")
        }
        
        if priceRangeSlider.lowerValue == priceRangeSlider.minimumValue {
            return " ≤ \( round( priceRangeSlider.upperValue ) ) €"
        }
        
        if priceRangeSlider.upperValue == priceRangeSlider.maximumValue {
            return " ≥ \( round( priceRangeSlider.lowerValue ) ) €"
        }
        
        return "\( round( priceRangeSlider.lowerValue ) ) € - \( round( priceRangeSlider.upperValue ) ) €"
    }
    
    // MARK: - Actions
    
    @objc func priceRangeSliderValueChanged(_ sender: RangeSlider) {
        priceLabel.text = String(format: NSLocalizedString("class_finder_price_label", comment: ""), getPriceLabel())
    }

    @IBAction func radioSliderValueChange(_ sender: UISlider) {
        distanceLabel.text = String(format: NSLocalizedString("class_finder_distance_label", comment: ""), roundf( distanceSlider.value ))
    }

    @IBAction func search(_ sender: Any) {
        let selectedSport = activityView.indexPathsForSelectedItems?.first
        let selectedLocat = locationView.indexPathsForSelectedItems?.first
        
        guard let pathSport = selectedSport, let pathLocation = selectedLocat else {
            return
        }
        
        presenter.onSearch(
            sportIndex: pathSport.row,
            locationIndex: pathLocation.row,
            distance: Int( roundf(distanceSlider.value) ),
            priceFrom: Int( round(priceRangeSlider.lowerValue) ),
            priceTo: Int( round(priceRangeSlider.upperValue))
        )
    }
}

extension ClassFinderViewController {
    func resetPriceRange() {
        priceRangeSlider.trackHighlightTintColor = UIColor.customOrange
        priceRangeSlider.maximumValue = 50;
        priceRangeSlider.upperValue = 50
        priceRangeSlider.minimumValue = 1;
        priceRangeSlider.lowerValue = 1
    }
    
    func resetInputs() {
        if locationView.indexPathsForSelectedItems == nil || locationView.indexPathsForSelectedItems?.count == 0 {
            locationView.selectFirst()
        }
        
        if activityView.indexPathsForSelectedItems == nil || activityView.indexPathsForSelectedItems?.count == 0 {
            activityView.selectFirst()
        }
        
        distanceSlider.value = 15
        resetPriceRange()
    }
    
    func restoreLastQuery() {
        guard let query = presenter.lastQuery() else {
            return
        }
        
        distanceSlider.value = Float( query.distance )
        priceRangeSlider.upperValue = Double( query.priceTo ?? 50 )
        priceRangeSlider.lowerValue = Double( query.priceFrom ?? 1 )
        
        activityView.selectItemAt(query.sportIndex)
        locationView.selectItemAt(query.locationIndex)
    }
    
    func setupPriceRangeSliderView() {
        priceRangeSliderView.addSubview(priceRangeSlider)
        
        priceRangeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["priceRangeSlider": priceRangeSlider]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[priceRangeSlider]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[priceRangeSlider]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: priceRangeSlider, attribute: .width, relatedBy: .equal, toItem: priceRangeSliderView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: priceRangeSlider, attribute: .height, relatedBy: .equal, toItem: priceRangeSliderView, attribute: .height, multiplier: 1, constant: 0))
        
        priceRangeSliderView.addConstraints(constraints)
    }
    
    func setupActivitiesView() -> ActivityStripView {
        let collectionView = ActivityStripView.instantiate()
        
        activityStripView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["activitiesView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[activitiesView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[activitiesView]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: activityStripView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: activityStripView, attribute: .height, multiplier: 1, constant: 0))
        
        activityStripView.addConstraints(constraints)
        
        return collectionView
    }
    
    func setupLocationsView() -> LocationStripView {
        let collectionView = LocationStripView.instantiate()
        
        locationStripView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["locationsView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[locationsView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[locationsView]", options: [], metrics: nil, views: viewDict))
        
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: locationStripView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: locationStripView, attribute: .height, multiplier: 1, constant: 0))
        
        locationStripView.addConstraints(constraints)
        
        return collectionView
    }
    
    func refreshLocationsHeight() {
        let filteredConstraints = locationStripView.constraints.filter { $0.identifier == "locationsHeightConstraint" }
        if let constraint = filteredConstraints.first {
            constraint.constant = CGFloat((UserSettings.user?.locations ?? []).count * 40 + 8)
        }
    }
    
    func refreshLocationsLayout() {
        guard let locationView = locationView else {
            return
        }
        
        locationView.invalidateLayout()
    }
}
