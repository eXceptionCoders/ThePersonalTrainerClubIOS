//
//  NewClassViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class NewClassViewController: BaseViewController, NewClassContract.View {
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityStripView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var assistanceLabel: UILabel!
    @IBOutlet weak var assistanceSlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: DefaultButton!
    
    lazy var presenter: NewClassContract.Presenter = NewClassViewPresenter(view: self, newClassUseCase: NewClassUseCase(newClassProvider: ClassProvider(webService: WebService())))

    
    let activities: [ActivityModel] = [
        ActivityModel(id: "1", name: "Arch", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/archer-stick-man-with-an-arch.png", category: ""),
        ActivityModel(id: "2", name: "Soccer", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/stick-man-playing-soccer.png", category: ""),
        ActivityModel(id: "3", name: "Athlete", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/athlete-stick-man.png", category: ""),
        ActivityModel(id: "4", name: "Skiing", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/skiing-stick-man.png", category: ""),
        ActivityModel(id: "5", name: "Bascket", description: "", thumbnail: "https://thepersonaltrainerclubcdn.azureedge.net/activities/ball-on-stick-man-arms.png", category: ""),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Class"
        
        let activityView = setupActivitiesView()
        
        activityView.items = activities
    }
    
    func showLoading() {
        // activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        // activityIndicator.stopAnimating()
    }
}

extension NewClassViewController {
    func setupActivitiesView() -> ActivityStripView {
        let collectionView = ActivityStripView.instantiate()
        
        activityStripView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["collectionView": collectionView]
        
        // Horizontals
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[collectionView]-0-|", options: [], metrics: nil, views: viewDict)
        
        // Verticals
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[collectionView]", options: [], metrics: nil, views: viewDict))

        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: activityStripView, attribute: .width, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: activityStripView, attribute: .height, multiplier: 1, constant: 0))
        
        activityStripView.addConstraints(constraints)
        
        return collectionView
    }
}
