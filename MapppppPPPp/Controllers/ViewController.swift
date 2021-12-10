//
//  ViewController.swift
//  MapppppPPPp
//
//  Created by Преподаватель on 09.12.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    let locationManger = CLLocationManager()
    var anotations: [MKAnnotation] = []
    var polyline: [MKPolyline] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        map.delegate = self
        
        if anotations.count > 1{
            map.addAnnotations(anotations)
            map.showAnnotations(anotations, animated: true)
        }else{
            map.addAnnotation(anotations.first!)
            
            mapThis(destinationCord: anotations.first!.coordinate)
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D) {
        
        let souceCordinate = (locationManger.location?.coordinate)!
        
        let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: soucePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .walking
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if error != nil {
                    print("Something is wrong :(")
                }
                return
            }
            
          let route = response.routes[0]
          self.map.addOverlay(route.polyline)
        self.polyline.append(route.polyline)
          self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        map.removeOverlays(polyline)
        polyline = []
        print("sdwsdwdw")
        mapThis(destinationCord: view.annotation!.coordinate)
    }
}

