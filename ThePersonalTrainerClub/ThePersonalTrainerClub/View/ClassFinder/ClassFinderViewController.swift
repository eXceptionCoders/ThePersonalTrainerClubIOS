//
//  ClassFinderViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassFinderViewController: BaseViewController, ClassFinderContract.View {
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
    
    let priceRangeSlider = RangeSlider(frame: CGRect.zero)
    
    lazy var presenter: ClassFinderContract.Presenter = ClassFinderViewPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("class_finder_title", comment: "")
        
        priceRangeSlider.trackHighlightTintColor = UIColor.customOrange
        priceRangeSlider.maximumValue = 50;
        priceRangeSlider.upperValue = 50
        priceRangeSlider.minimumValue = 1;
        priceRangeSlider.lowerValue = 1
        priceRangeSliderView.addSubview(priceRangeSlider)
        
        localizeView()
        
        priceRangeSlider.addTarget(self, action: #selector(ClassFinderViewController.priceRangeSliderValueChanged(_:)), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        priceRangeSlider.frame = CGRect(x: 0, y: 0, width: priceRangeSliderView.bounds.width, height: 40.0)
    }
    
    override func localizeView() {
        activityLabel.text = NSLocalizedString("class_finder_activity_label", comment: "")
        locationLabel.text = NSLocalizedString("class_finder_location_label", comment: "")
        distanceLabel.text = String(format: NSLocalizedString("class_finder_distance_label", comment: ""), roundf( distanceSlider.value ))
        priceLabel.text = String(format: NSLocalizedString("class_finder_price_label", comment: ""), getPriceLabel())
        searchButton.setTitle(NSLocalizedString("class_finder_search_button", comment: ""), for: .normal)
    }
    
    func setUser(_ user: UserModel) {
        // TODO
    }
    
    func getPriceLabel() -> String {
        if priceRangeSlider.lowerValue == priceRangeSlider.minimumValue && priceRangeSlider.upperValue == priceRangeSlider.maximumValue {
            return NSLocalizedString("class_finder_any_label", comment: "")
        }
        
        if priceRangeSlider.lowerValue == priceRangeSlider.minimumValue {
            return " < \( round( priceRangeSlider.upperValue ) ) €"
        }
        
        if priceRangeSlider.upperValue == priceRangeSlider.maximumValue {
            return " > \( round( priceRangeSlider.lowerValue ) ) €"
        }
        
        return "\( round( priceRangeSlider.lowerValue ) ) € - \( round( priceRangeSlider.upperValue ) ) €"
    }
    
    @objc func priceRangeSliderValueChanged(_ sender: RangeSlider) {
        priceLabel.text = String(format: NSLocalizedString("class_finder_price_label", comment: ""), getPriceLabel())
    }

    @IBAction func radioSliderValueChange(_ sender: UISlider) {
        distanceLabel.text = String(format: NSLocalizedString("class_finder_distance_label", comment: ""), roundf( distanceSlider.value ))
    }

    @IBAction func search(_ sender: Any) {
    }
}
