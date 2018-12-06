//
//  NewClassViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class NewClassViewController: BaseViewController, NewClassContract.View {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityStripView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationStripView: UIView!
    @IBOutlet weak var assistanceLabel: UILabel!
    @IBOutlet weak var assistanceSlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: DefaultButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var activityView: ActivityStripView!
    var locationView: LocationStripView!
    lazy var presenter: NewClassContract.Presenter = NewClassViewPresenter(view: self, newClassUseCase: NewClassUseCase(newClassProvider: ClassProvider(webService: WebService())))

    override func localizeView() {
        activityLabel.text = NSLocalizedString("newclass_whatactivity_label", comment: "")
        locationLabel.text = NSLocalizedString("newclass_where_label", comment: "")
        assistanceLabel.text = String(format: NSLocalizedString("newclass_assistance_label", comment: ""), assistanceSlider.value)
        priceLabel.text = String(format: NSLocalizedString("newclass_price_label", comment: ""), priceSlider.value)
        descriptionLabel.text = NSLocalizedString("newclass_description_label", comment: "")
        
        saveButton.setTitle(NSLocalizedString("newclass_save_button", comment: ""), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("newclass_title", comment: "")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewClassViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor.customDark.cgColor
        
        activityView = setupActivitiesView()
        locationView = setupLocationsView()
        hideLoading()
        presenter.fetchUser()
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
    
    func setUser(_ user: UserModel) {
        activityView.items = user.activities
        locationView.items = user.locations
        refreshLocationsHeight()
        resetInputs()
    }
    
    @IBAction func assisntanceSliderValueChanged(_ sender: Any) {
        let fixed = roundf((sender as! UISlider).value);
        (sender as! UISlider).setValue(fixed, animated: true)
        
        assistanceLabel.text = String(format: NSLocalizedString("newclass_assistance_label", comment: ""), assistanceSlider.value)
    }
    
    @IBAction func priceSliderValueChanged(_ sender: Any) {
        let fixed = roundf((sender as! UISlider).value);
        (sender as! UISlider).setValue(fixed, animated: true)
        
        priceLabel.text = String(format: NSLocalizedString("newclass_price_label", comment: ""), priceSlider.value)
    }
    
    @IBAction func saveClass(_ sender: Any) {
        let selectedSport = (activityStripView.subviews.first as! ActivityStripView).indexPathsForSelectedItems?.first
        let selectedLocat = (locationStripView.subviews.first as! LocationStripView).indexPathsForSelectedItems?.first
        
        guard let pathSport = selectedSport, let pathLocation = selectedLocat else {
            return
        }
        
        let sport = UserSettings.user?.activities[pathSport.row]
        let location = UserSettings.user?.locations[pathLocation.row]
        
        presenter.onCreate(sport: sport!.id, description: descriptionTextView.text, price: priceSlider.value, quota: Int(assistanceSlider.value), location: location!)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
            //scrollView.isScrollEnabled = true
        } else {
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            
            scrollView.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            //scrollView.isScrollEnabled = false
        }
    }
    
    override func showLoading() {
        activityIndicator.startAnimating()
    }
    
    override func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension NewClassViewController {
    func resetInputs() {
        if (UserSettings.user?.locations.count ?? 0 > 0) {
            (locationStripView.subviews.first as! LocationStripView).selectFirst()
        }
        
        if (UserSettings.user?.activities.count ?? 0 > 0) {
            (activityStripView.subviews.first as! ActivityStripView).selectFirst()
        }

        priceSlider.value = 15
        assistanceSlider.value = 20
        descriptionTextView.text = ""
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
