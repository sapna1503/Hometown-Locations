//
//  MapViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 11/2/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var latitude: String = "0.0"
    var longitude: String = "0.0"

    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var dataDictionary: [String: Any] = [:]

    @IBOutlet weak var mapView: MKMapView!

    @IBAction func addPinpoint(_ sender: UILongPressGestureRecognizer) {
        let existingAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(existingAnnotations)
        let location = sender.location(in: self.mapView)
        let locCoord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
        annotation.title = "Location"
        self.mapView.addAnnotation(annotation)
        latitude = String(locCoord.latitude)
        longitude = String(locCoord.longitude)
    }

    @IBAction func btnOk(_ sender: Any) {
        performSegue(withIdentifier: "segueToGetLocation", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToGetLocation" {
            let destination = segue.destination as? AddNewUserViewController
            destination?.latitude = latitude
            destination?.longitude = longitude
            destination?.dataDictionary = dataDictionary
            destination?.from = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showEnteredLocation(latitude: (dataDictionary["latitude"] as! NSString).doubleValue, longitude: (dataDictionary["longitude"] as! NSString).doubleValue)
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func showEnteredLocation(latitude: Double, longitude: Double)
    {
        if(latitude != 0.0 && longitude != 0.0) {
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.10, 0.10)
            let annotation = MKPointAnnotation()
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            annotation.coordinate = userLocation
            var nickname = dataDictionary["nickname"] as! String
            if nickname == "" { nickname = "Nickname"
            }
            annotation.title = nickname
            self.mapView.addAnnotation(annotation)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
            self.mapView.setRegion(region, animated: true)
        }
        else
        {
            let overlays = mapView.overlays
            mapView.removeOverlays(overlays)
            let searchRequest = MKLocalSearchRequest()
            searchRequest.naturalLanguageQuery = (dataDictionary["city"] as! String)
            
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start { (response, error) in

                if response == nil
                    {
                    print("No response")
                }
                else
                {
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude

//                    let rounded_latitude = Double(round(1000000 * Double(latitude!) / 1000000))
//                    let rounded_longitude =  Double(round(1000000 * Double(longitude!) / 1000000))
//                    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(rounded_latitude, rounded_longitude)
                    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
//                    print ("==========Hey===========\(coordinate)")
//                    print (coordinate)
                    let span = MKCoordinateSpanMake(0.8, 0.8)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    self.mapView.setRegion(region, animated: true)
                }
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
