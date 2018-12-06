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
        priceRangeSlider.trackHighlightTintColor = UIColor.customOrange
        priceRangeSlider.maximumValue = 50;
        priceRangeSlider.upperValue = 50
        priceRangeSlider.minimumValue = 1;
        priceRangeSlider.lowerValue = 1
        priceRangeSliderView.addSubview(priceRangeSlider)
        
        priceRangeSlider.addTarget(self, action: #selector(ClassFinderViewController.priceRangeSliderValueChanged(_:)), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        priceRangeSlider.frame = CGRect(x: 0, y: 0, width: priceRangeSliderView.bounds.width, height: 40.0)
    }
    
    override func localizeView() {
        
    }
    
    func setUser(_ user: UserModel) {
        // TODO
    }
    
    @objc func priceRangeSliderValueChanged(_ sender: RangeSlider) {
        
        let lowerValue = round(sender.lowerValue)
        let upperValue = round(sender.upperValue)
        
        print("Range slider value changed: (\(lowerValue) , \(upperValue))")
    }

    @IBAction func radioSliderValueChange(_ sender: UISlider) {
        let priceFixed = roundf(sender.value);
        
        distanceLabel.text = String(format: NSLocalizedString("class_finderr_radio_label", comment: ""), priceFixed)
    }

    @IBAction func search(_ sender: Any) {
    }
}
