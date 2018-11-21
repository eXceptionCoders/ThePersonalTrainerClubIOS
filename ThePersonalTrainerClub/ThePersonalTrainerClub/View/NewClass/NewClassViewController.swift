//
//  NewClassViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class NewClassViewController: BaseViewController, NewClassContract.View {
    
    let activities: [ActivityModel] = [
        ActivityModel(id: "1", name: "Arch", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/archer-stick-man-with-an-arch.png", category: ""),
        ActivityModel(id: "2", name: "Soccer", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/stick-man-playing-soccer.png", category: ""),
        ActivityModel(id: "3", name: "Athlete", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/athlete-stick-man.png", category: ""),
        ActivityModel(id: "4", name: "Skiing", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/skiing-stick-man.png", category: ""),
        ActivityModel(id: "5", name: "Bascket", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/ball-on-stick-man-arms.png", category: ""),
        ]
    
    let locations: [LocationModel] = [
        LocationModel(type: "Point", coordinates: [], description: "Gym Eurosport"),
        LocationModel(type: "Point", coordinates: [], description: "Parque García Sanabria"),
        LocationModel(type: "Point", coordinates: [], description: "Gym Laguna Center"),
        LocationModel(type: "Point", coordinates: [], description: "Polideportivo Lo Llanos"),
        ]
    
    
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
        title = "New Class"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewClassViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.borderColor = UIColor.customDark.cgColor
        
        let activityView = setupActivitiesView()
        let locationView = setupLocationsView()
        
        activityView.items = activities
        locationView.items = locations
        refreshLocationsHeight()
        hideLoading()
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
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension NewClassViewController {
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
            constraint.constant = CGFloat(locations.count * 40)
        }
    }
    
    func refreshLocationsLayout() {
        (self.locationStripView.subviews.first as! LocationStripView).invalidateLayout()
    }
}
