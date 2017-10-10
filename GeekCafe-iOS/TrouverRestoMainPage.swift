//
//  TrouverRestoMainPage.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-09-19.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class TrouverRestoMainPage: UIViewController,GMSMapViewDelegate,UITextFieldDelegate{

    let menu = MenuClass()
    let containerView = UIView()
    
    var coordinates:[CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    var searchLocation:CLLocation = CLLocation()
    var markers = [GMSMarker]()
    let mapView = GMSMapView()
    let regionRadius: CLLocationDistance = 1000
    let TB_Search = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.setUpMenu(view: self.view)
        setUpContainerView()
        menu.setUpFakeNavBar(view: containerView, titleTop: "Trouver un restaurant")
        
        //Page Set Up
        fillFakeCoordinates()
        setUpMap()
        setUpPinOnMap()
        setUpBottom()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        focusMapToShowAllMarkers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpContainerView(){
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
    }
  
    func setUpMap(){
        mapView.delegate = self
        mapView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: rh(486))
        applyMapStyle()
        containerView.addSubview(mapView)
    }
    
    func setUpBottom(){
        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: rh(547), width: view.frame.width, height: rh(120))
        bottomView.backgroundColor = UIColor.white
        bottomView.makeShadow(x: 0, y: 0, blur: 6, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.1, spread: 0)
        containerView.addSubview(bottomView)
        
        let LBL_CodePostalD = UILabel()
        LBL_CodePostalD.createLabel(frame: CGRect(x:rw(38),y:rh(30),width:rw(100),height:rh(12)), textColor: Utility().hexStringToUIColor(hex: "#AFAFAF"), fontName: "Lato-Light", fontSize: rw(10), textAignment: .left, text: "Code Postal")
        bottomView.addSubview(LBL_CodePostalD)
        
        TB_Search.delegate = self
        TB_Search.frame = CGRect(x: LBL_CodePostalD.frame.minX, y: LBL_CodePostalD.frame.maxY, width: rw(141), height: rh(48))
        TB_Search.placeholder = "Search..."
        TB_Search.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "6CA642"), fontName: "Lato-Light", fontSize: rw(40))
        TB_Search.textAlignment = .left
        TB_Search.textColor = Utility().hexStringToUIColor(hex: "6CA642")
        TB_Search.font = UIFont(name: "Lato-Light", size: rw(36))
        bottomView.addSubview(TB_Search)
        
        Utility().createHR(x: TB_Search.frame.minX, y: TB_Search.frame.maxY, width: TB_Search.frame.width, view: bottomView, color: Utility().hexStringToUIColor(hex: "#999999"))
    }
   
    //
    //
    //Fill array de markers with coordinates
    //
    //
    func setUpPinOnMap(){
        
        
        for x in coordinates{
            let marker = GMSMarker()
            
            marker.position = x
            marker.title = "31 boul du faubourg, Boisbriand, J7F4G9"
            marker.icon = UIImage(named:"pin_little")
            marker.map = self.mapView
            marker.opacity = 1.0
            markers.append(marker)
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let containerView = UIView()
        containerView.frame.size = CGSize(width: rw(280), height: rh(45))
        containerView.backgroundColor = UIColor.clear
        
        let markerImage = UIImage(named: "Tooltip")
        let viewImage = UIImageView(image:markerImage)
        viewImage.frame = CGRect(x: 0, y: 0, width: rw(140), height: rh(40))
        containerView.addSubview(viewImage)
        
        let title = UILabel()
        title.createLabel(frame: CGRect(x:rw(5),y:rh(2),width:viewImage.frame.width - rw(10),height:rh(30)), textColor: Utility().hexStringToUIColor(hex: "#FFFFFF"), fontName: "Lato-Regular", fontSize: rw(12), textAignment: .center, text: marker.title!)
        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail
        viewImage.addSubview(title)
        
        return containerView
    }
    
    //
    //
    //Quand une pin est tapper
    //
    //
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        focusMapOnSingleMarker(marker: marker)
        mapView.selectedMarker = marker
        return true
    }
    
    //
    //
    //Focus on all markers
    //
    //
    func focusMapToShowAllMarkers() {
        let myLocation: CLLocationCoordinate2D = self.markers.first!.position
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        for marker in self.markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        self.mapView.animate(with:update)
    }
    
    func focusMapOnSingleMarker(marker:GMSMarker){
        let myLocation: CLLocationCoordinate2D = marker.position
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        self.mapView.animate(with:update)
    }
    
    //
    //
    //Get closest pin the entered location
    //
    //
    func getClosestPin(postalCode:String)->GMSMarker{
        var closestMarker = GMSMarker()
        getLocationSearch(postalCode: postalCode)
    
        var index = 0
        var smallestDistance:Double = 0
        for x in markers{
            let markerLocation = CLLocation(latitude: x.position.latitude, longitude: x.position.longitude)
            let metres = searchLocation.distance(from: markerLocation)

            if(index == 0){
                smallestDistance = metres
            }
            
            if(smallestDistance > metres){
                smallestDistance = metres
                closestMarker = x
            }
            
            index += 1
        }
        
        return closestMarker
    }
    
    func getLocationSearch(postalCode:String){
        //var coordinates = CLLocationCoordinate2D()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(postalCode) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    return
            }
            self.searchLocation = location
        }
    }
    
    //
    //
    //Fill Coordinates
    //
    //
    func fillFakeCoordinates(){
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(45.69179211), longitude: CLLocationDegrees(-73.644104)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(45.64764837), longitude: CLLocationDegrees(-73.85009766)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(45.68987354), longitude: CLLocationDegrees(-73.77868652)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(45.65244829), longitude: CLLocationDegrees(-74.09729004)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(45.55637174), longitude: CLLocationDegrees(-73.90365601)))
    }
    
    //
    //
    //Get json style for google maps
    //
    //
    func applyMapStyle(){
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
    }

}
