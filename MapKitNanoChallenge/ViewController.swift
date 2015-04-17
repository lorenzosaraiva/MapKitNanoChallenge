//
//  ViewController.swift
//  MapKitNanoChallenge
//
//  Created by Lorenzo Saraiva on 4/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        /* Location Manager */
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var myRootRef = Firebase(url:"https://sizzling-inferno-6992.firebaseio.com/")
        if (UIDevice.currentDevice().name == "Lorenzo Saraiva"){
            var centerLocation = CLLocationCoordinate2DMake(
                manager.location.coordinate.latitude, manager.location.coordinate.longitude)
            var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
            var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            mapView.setRegion(mapRegion, animated: true)
            var point = MKPointAnnotation()
            point.coordinate = centerLocation
            mapView.addAnnotation(point)
            
            //firebase
            var myLocation = ["latitude":manager.location.coordinate.latitude,"longitude":manager.location.coordinate.longitude]
            var myLocationRef = myRootRef.childByAppendingPath("MyLocation")
            myLocationRef.setValue(myLocation)
        }
        else{
            // Get the data on a post that has changed
            myRootRef.observeEventType(.ChildChanged, withBlock: { snapshot in
                println(snapshot.value.objectForKey("latitude"))
                println(snapshot.value.objectForKey("longitude"))
            })
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? MyAnnotation{
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                
            }
            return view
        }
        return nil
    }
    
    
}

