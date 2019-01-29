//
//  SelectLocationOnMapVC.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import UIKit
import MapKit

let klocationArray = "locationArray"
let kcity = "city"
let klat = "lat"
let klon = "lon"

@objc protocol SelectLocationOnMapVCDelegate {
    func refreshLocationList()
}

class SelectLocationOnMapVC: UIViewController {

    weak var delagate : SelectLocationOnMapVCDelegate?
    var selectedLocation : CLLocationCoordinate2D?
    var selectedCity : String?

    @IBOutlet weak var mpView: MKMapView!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @IBAction func doneBtnAction(_ sender: UIBarButtonItem) {
        if (selectedLocation != nil) {
            
            let userDefaults = UserDefaults.standard
            var array = userDefaults.object(forKey: klocationArray) as? Array<[String:Any]>
            if array == nil {
                array = Array<[String:Any]>()
            }else{
                //Do Nothing
            }
            
            array?.append([kcity:selectedCity!, klat: selectedLocation!.latitude, klon: selectedLocation!.longitude])
            userDefaults.set(array!, forKey: klocationArray)
            userDefaults.synchronize()
            delagate?.refreshLocationList()
            dismiss(animated: true, completion: nil)
        }
        else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func tapGestureRecognizerAction(_ sender: UIGestureRecognizer) {
        let locationInView = sender.location(in: mpView)
        let location = mpView.convert(locationInView, toCoordinateFrom: mpView)
        getAddressFromLatLon(clLocationCoordinate2D: location)
    }
    
    
    // MARK: - Private
    
    private func addAnnotation(mkPointAnnotation: MKPointAnnotation){
        mpView.removeAnnotations(mpView.annotations)
        mpView.addAnnotation(mkPointAnnotation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.mpView.selectAnnotation(mkPointAnnotation, animated: true)
        }
    }
    
    private func getAddressFromLatLon(clLocationCoordinate2D: CLLocationCoordinate2D) {
        let ceo: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude:clLocationCoordinate2D.latitude, longitude: clLocationCoordinate2D.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country!
                    }
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = clLocationCoordinate2D
                    annotation.title = addressString
                    self.addAnnotation(mkPointAnnotation: annotation)
                    self.selectedLocation = clLocationCoordinate2D
                    self.selectedCity = addressString
                }
        })
    }
}


    // MARK: - MKMapViewDelegate

extension SelectLocationOnMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = nil//UIButton(type: .infoDark)
            pinView!.pinTintColor = UIColor.red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}
