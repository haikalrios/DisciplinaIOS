//
//  ViewController.swift
//  IOSJsonCosumer
//
//  Created by HC5MAC12 on 21/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {

    private var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.delegate =  self
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addPin(_:)))
            longPress.minimumPressDuration = 2
            mapView.addGestureRecognizer(longPress)
        }
    }
    
    @objc private func addPin(_ sender: UILongPressGestureRecognizer){
        let annotations  = mapView.annotations.filter{ (annotation) -> Bool in
            return annotation.isKind(of: MKPointAnnotation.self)
        }
        mapView.removeAnnotations(annotations)
        
        let touchPoint = sender.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "haikal"
        annotation.subtitle = "oi"
        
        mapView.addAnnotation(annotation)
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }


}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKPointAnnotation.self){
            let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myMarker")
            view.isDraggable = true
            return view
        }
       return nil
    }
 
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last{
            let camera = MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 2000, pitch: 0, heading: 0)
            mapView.setCamera(camera, animated: true)
            mapView.showsUserLocation =  true
        }
    }
}



