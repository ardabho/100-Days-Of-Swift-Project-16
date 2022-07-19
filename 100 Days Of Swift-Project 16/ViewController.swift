//
//  ViewController.swift
//  100 Days Of Swift-Project 16
//
//  Created by Arda Büyükhatipoğlu on 18.07.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        askMapType()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change Map", style: .plain, target: self, action: #selector(askMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func askMapType() {
        let ac = UIAlertController(title: "Welcome", message: "How would you like to see the map?", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "standard", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "hybrid", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "hybridFlyover", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "mutedStandard", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "satellite", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "satelliteFlyover", style: .default, handler: changeMapType))
        
        present(ac, animated: true)
    }
    
    func changeMapType(action: UIAlertAction) {
        switch action.title {
        case "standard":
            mapView.mapType = .standard
        case "hybrid":
            mapView.mapType = .hybrid
        case "hybridFlyover":
            mapView.mapType = .hybridFlyover
        case "mutedStandard":
            mapView.mapType = .mutedStandard
        case "satellite":
            mapView.mapType = .satellite
        case "satelliteFlyover":
            mapView.mapType = .satelliteFlyover
        default:
            fatalError("Couldnt find map type")
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView.pinTintColor = .blue
            annotationView.annotation = annotation
            return annotationView
        } else {
            let newAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            newAnnotationView.canShowCallout = true
            newAnnotationView.pinTintColor = .blue
            
            let btn = UIButton(type: .detailDisclosure)
            newAnnotationView.rightCalloutAccessoryView = btn
            return newAnnotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
//        let placeInfo = capital.info
        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        
        let vc = WebViewController()
        vc.countryName = placeName
        navigationController?.pushViewController(vc, animated: true)
    }
}

