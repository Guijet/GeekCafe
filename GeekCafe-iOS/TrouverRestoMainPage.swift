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
    var closestMarker = GMSMarker()
    let mapView = GMSMapView()
    let regionRadius: CLLocationDistance = 1000
    let TB_Search = UITextField()
    var arrayDistance = [Double]()
    var closestDistance:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menu.setUpMenu(view: self.view)
        self.setUpContainerView()
        self.menu.setUpFakeNavBar(view: self.containerView, titleTop: "Trouver un restaurant")
        DispatchQueue.global().async {
            self.fillFakeCoordinates()
            DispatchQueue.main.async {
                self.setUpMap()
                self.applyMapStyle()
                self.setUpPinOnMap()
                self.setUpBottom()
            }
            //To find to closest pin send the adress in parameter or postalCode
            //self.getLocationSearch(postalCode: "j7b1x2")
        }
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
        TB_Search.autocapitalizationType = .allCharacters
        TB_Search.autocorrectionType = .no
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
    //MAP SET UPS AND FUNCTIONS
    //
    //

    //Fill array de markers with coordinates
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
    
    //Custom Markers
    //
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

    //Quand une pin est tapper
    //
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        focusMapOnSingleMarker(marker: marker)
        mapView.selectedMarker = marker
        return true
    }
    
    //Focus on all markers
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
    
    //Focus on a single marker
    //
    func focusMapOnSingleMarker(marker:GMSMarker){
        let myLocation: CLLocationCoordinate2D = marker.position
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets.zero)
        self.mapView.animate(with:update)
        self.mapView.animate(toZoom: 12)
    }

    //Get closest pin the entered location
    //
    func getClosestDistance(arrayDistance:[Double])->Double{
        var closestDistance:Double = 0
        var index:Int = 0
        if(arrayDistance.count > 0){
            for x in arrayDistance{
                if(index == 0){
                    closestDistance = x
                }
                else{
                    if(x < closestDistance){
                        closestDistance = x
                    }
                }
                index += 1
            }
        }
        return closestDistance
    }
    
    //Get closest pin the entered location
    //
    func getClosestMarker(locationEntered:CLLocation)->GMSMarker{
        
        var closestMarker:GMSMarker = GMSMarker()
        var closestDistance:Double = 0
        var index:Int = 0
        if(markers.count > 0){
            for x in markers{
                if(index == 0){
                    closestDistance = locationEntered.distance(from: CLLocation(latitude: x.position.latitude, longitude:  x.position.longitude))
                    closestMarker = x
                }
                else{
                    if(locationEntered.distance(from: CLLocation(latitude: x.position.latitude, longitude:  x.position.longitude)) < closestDistance){
                        closestDistance = locationEntered.distance(from: CLLocation(latitude: x.position.latitude, longitude:  x.position.longitude))
                        closestMarker = x
                    }
                }
                index += 1
            }
        }
        return closestMarker
    }
    
    //API Request to get locaton with adress entered
    //
    func getLocationSearch(postalCode:String){
        
        CLGeocoder().geocodeAddressString(postalCode, completionHandler: {(placemarks, error) in
            if(error != nil){
                print("There is an error")
            }
            else{
                if let placemark = placemarks?.first{
                    if let location = placemark.location{
                        self.closestMarker = self.getClosestMarker(locationEntered: location)
                    }
                }
            }
        })
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
    
    
    //
    //
    //TextFields functions and delegate
    //
    //
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if(textField == TB_Search){
            if(textField.text!.characters.count > 5){
                if (isBackSpace != -92) {
                    return false
                }
            }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
