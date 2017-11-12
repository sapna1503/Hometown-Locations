//
//  ExistingUsersInMapViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 11/5/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit
import MapKit

class ExistingUsersInMapViewController: UIViewController {
    var personArray = [Person]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    //segueExistingUserInMaps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = (self as! MKMapViewDelegate)
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        createPinPoint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createPinPoint()
    {
//        var allAnnMapRect = MKMapRectNull
//
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
//
        for person in personArray{
           
            
            let annotation = MKPointAnnotation()
            annotation.title = person.nickname
            let location =  CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
            
            print ("HI\(person.latitude) , \(person.longitude)")
//            let thisAnnMapPoint = MKMapPointForCoordinate(annotation.coordinate)
//            let thisAnnMapRect = MKMapRectMake(thisAnnMapPoint.x, thisAnnMapPoint.y, 1, 1)
//            allAnnMapRect = MKMapRectUnion(allAnnMapRect, thisAnnMapRect)
//
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
            
        }
        
       
        
//        let yourAnnotationArray = mapView.annotations
//        mapView.showAnnotations(yourAnnotationArray, animated: true)
//        mapView.camera.altitude *= 1.4

      self.mapView.showAnnotations(self.mapView.annotations, animated: true)
//        let edgeInset = UIEdgeInsetsMake(30,30,30,30)
//        self.mapView.setVisibleMapRect(allAnnMapRect, edgePadding: edgeInset, animated: true)
       
    }
}
