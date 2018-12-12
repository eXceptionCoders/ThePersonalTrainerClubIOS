//
//  ClassFinderResultViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 06/12/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class ClassFinderResultViewController: BaseViewController, ClassFinderResultContract.View, ClassStripViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var lessonsView: UIView!
    
    // MARK: - Properties
    
    private lazy var classesView: ClassStripView = setupLessonsView()
    
    var query: ClassFinderQuery
    
    // MARK: - Presenter
    
    lazy var presenter: ClassFinderResultContract.Presenter = ClassFinderResultViewPresenter(
        view: self,
        trainerManagementUseCase: TrainerManagementUseCase(
            userProvider: UserProvider(webService: WebService()),
            classProvider: ClassProvider(webService: WebService()),
            bookingProvider: BookingProvider(webService: WebService())
        ),
        findClassesUseCase: FindClassesUseCase(classProvider: ClassProvider(webService: WebService()))
    )
    
    // MARK: - Initialization
    
    init(query: ClassFinderQuery) {
        self.query = query
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.fetchClasses(query)
    }

    // MARK: - BaseViewController methods
    
    override func localizeView() {
        title = NSLocalizedString("class_finder_result_title", comment: "")
        notFoundLabel.text = NSLocalizedString("class_finder_result_classes_not_found", comment: "")
    }
    
    override func showLoading() {
        matchesLabel.isHidden = true
        notFoundLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    override func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - ClassFinderResultContract.View methods
    
    func setClasses(_ classes: [ClassModel], _ total: Int) {
        matchesLabel.text = String(format: NSLocalizedString("class_finder_result_found", comment: ""), total)
        
        matchesLabel.isHidden = total == 0
        notFoundLabel.isHidden = total > 0
        
        classesView.items = classes
        refreshLessonsLayout()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    // MARK: - ClassStripViewDelegate methods
    
    func classStripViewDelegate(_ view: ClassStripView, didSelectClass: ClassModel) {
        presenter.onClassTapped(didSelectClass)
    }
    
    func classStripViewDelegate (_ view: ClassStripView, didCancelClass: ClassModel) {
        
    }
    
    func classStripViewDelegate (_ view: ClassStripView, didBookClass: ClassModel) {
        let alertController = UIAlertController(title: NSLocalizedString("booking_title", comment: ""), message: String(format: NSLocalizedString("booking_message", comment: ""), didBookClass.sport.name), preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: NSLocalizedString("booking_button_title", comment: ""), style: .destructive) { (_) in
            self.presenter.book(didBookClass.id)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel_button_title", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ClassFinderResultViewController {
    func setupLessonsView() -> ClassStripView {
        let collectionView = ClassStripView.instantiate()
        collectionView.showBookingButton = true
        collectionView.delegate = self
        
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
