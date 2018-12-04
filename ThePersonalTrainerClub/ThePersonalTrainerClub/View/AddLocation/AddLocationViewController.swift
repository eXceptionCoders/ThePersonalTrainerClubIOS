//
//  AddLocationViewController.swift
//  ThePersonalTrainerClub
//
//  Created by VINACHES LOPEZ JORGE on 26/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddLocationViewController: BaseViewController, AddLocationContract.View {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var setLocationTitleLabel: UILabel!
    @IBOutlet weak var locationDescriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var currentLocationButton: DefaultButton!
    @IBOutlet weak var saveButton: DefaultButton!
    
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation? = nil
    
    lazy var geocoder = CLGeocoder()
    
    var resultSearchController:UISearchController? = nil
    
    var selectedPin:MKPlacemark? = nil
    
    var currentLatitude: Double? = nil
    var currentLongitude: Double? = nil
    
    lazy var presenter: AddLocationContract.Presenter = AddLocationViewPresenter(view: self, addLocationUseCase: AddLocationUseCase(provider: LocationProvider(webService: WebService())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = SearchLocationTableViewController()
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = NSLocalizedString("add_location_search_placeholder", comment: "")
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    override func localizeView() {
        setLocationTitleLabel.text = NSLocalizedString("add_location_set_location_title", comment: "")
        locationDescriptionTextField.placeholder = NSLocalizedString("add_location_location_description_placeholder", comment: "")
        locationTextField.placeholder = NSLocalizedString("add_location_location_placeholder", comment: "")
        currentLocationButton.setTitle(NSLocalizedString("add_location_use_current_location_button_title", comment: ""), for: .normal)
        saveButton.setTitle(NSLocalizedString("add_location_save_button_title", comment: ""), for: .normal)
    }

    @IBAction func onCurrentLocationTapped(_ sender: Any) {
        if let location = lastLocation {
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemarks = placemarks, let placemark = placemarks.first {
                    self.locationTextField.text = self.parseLocation(placemark)
                    self.currentLongitude = location.coordinate.longitude
                    self.currentLatitude = location.coordinate.latitude
                } else {
                    self.locationTextField.text = NSLocalizedString("add_location_no_address_found", comment: "")
                }
            }
        } else {
            showAlertMessage(title: nil, message: NSLocalizedString("add_location_no_last_location_message", comment: ""))
        }
    }
    
    @IBAction func onSaveTapped(_ sender: Any) {
        if let desc = locationDescriptionTextField.text, let lat = currentLatitude, let long = currentLongitude {
            presenter.onAddLocation(description: desc, latitude: lat, longitude: long)
        } else {
            showAlertMessage(title: nil, message: NSLocalizedString("add_location_on_save_error_message", comment: ""))
        }
    }
    
    func parseLocation(_ location: CLPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (location.subThoroughfare != nil && location.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (location.subThoroughfare != nil || location.thoroughfare != nil) && (location.subAdministrativeArea != nil || location.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (location.subAdministrativeArea != nil && location.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            location.subThoroughfare ?? "",
            firstSpace,
            // street name
            location.thoroughfare ?? "",
            comma,
            // city
            location.locality ?? "",
            secondSpace,
            // state
            location.administrativeArea ?? ""
        )
        return addressLine
    }
    
    func onLocationSaved() {
        print("")
    }
    
    func onLocationError() {
        print("")
    }
}

extension AddLocationViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlertMessage(title: nil, message: NSLocalizedString("add_location_user_location_error_title", comment: ""))
    }
}

extension AddLocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        locationTextField.text = parseLocation(placemark)
        currentLongitude = placemark.coordinate.longitude
        currentLatitude = placemark.coordinate.latitude
    }
}
