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
            marker.title = "My Pin"
            marker.icon = UIImage(named:"pin_little")
            marker.map = self.mapView
            marker.opacity = 1.0
            markers.append(marker)
        }
    }
    
    //
    //
    //Quand une pin est tapper
    //
    //
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        
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
    
    //
    //
    //Fill Coordinates
    //
    //
    func fillFakeCoordinates(){
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(47.4925), longitude: CLLocationDegrees(19.6613)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(46.728), longitude: CLLocationDegrees(19.2583)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(46.528), longitude: CLLocationDegrees(19.1553)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(47.228), longitude: CLLocationDegrees(19.4543)))
        coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(46.249), longitude: CLLocationDegrees(19.4533)))
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
