//
//  MyAnnotation.swift
//  
//
//  Created by Lorenzo Saraiva on 4/16/15.
//
//

import MapKit
import UIKit

class MyAnnotation: NSObject, MKAnnotation {
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D){
    
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
