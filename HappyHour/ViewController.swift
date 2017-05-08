//
//  ViewController.swift
//  HappyHour
//
//  Created by Tyler Gering on 2/15/17.
//  Copyright © 2017 Tyler Gering. All rights reserved.
//

import UIKit
import MapKit
import FBSDKLoginKit



class SelectView: UIViewController {
    
    var userName: String?
    
    @IBOutlet weak var logInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInLabel.text = "Logged In As " + userName!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier != "back"){
            let nextScene =  segue.destination as! BarViewController
            nextScene.name = segue.identifier
            nextScene.userName = userName
        }
    }
    
}


class BarViewController: UIViewController, UIScrollViewDelegate {
    
    var userName: String?
    var name: String?
    
    @IBOutlet weak var BarTitle: UILabel!
    @IBOutlet weak var BarMap: MKMapView!
    @IBOutlet weak var SpecialsText: UITextView!
    @IBOutlet weak var BarImage: UIImageView!
    @IBOutlet weak var SpecialsTitle: UITextView!
    @IBOutlet weak var CrowdRatingLabel: UILabel!
    
    var span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    var pin = MKPointAnnotation()
    var pinView = MKPinAnnotationView()
    var day = Calendar.current.component(.weekday, from: Date())
    var BarLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BarTitle.text = name
        BarLocation = InitializeMapCoordinates(title: name!)
        MapViewInitializer(BarLocation: BarLocation)
        SpecialsTextInitializer()
        GetCrowdRating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetCrowdRating(){
        CrowdRatingLabel.text = "Current Crowd Rating: *"
    }
    
    func InitializeMapCoordinates(title: String) -> CLLocationCoordinate2D{
        //RILEYS
        if(title == "Rileys Bar & Grill"){
            BarImage.image = #imageLiteral(resourceName: "RileysBuilding")
            let m_latitude = 39.7246
            let m_longitude = -121.8439
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
        
        //THE BEAR
        else if(title == "Madison Bear Garden"){
            BarImage.image = #imageLiteral(resourceName: "BearBuilding")
            let m_latitude = 39.7291
            let m_longitude = -121.8426
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
            
        //PANAMAS
        else if(title == "Panama Bar Cafe"){
            BarImage.image = #imageLiteral(resourceName: "PanamaBuilding")
            let m_latitude = 39.7305
            let m_longitude = -121.8397
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
        
        //JOES
        else if(title == "Joes Bar"){
            BarImage.image = #imageLiteral(resourceName: "JoesBuilding")
            let m_latitude = 39.7238
            let m_longitude = -121.8442
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
            
        //ARGUS
        else if(title == "Argus Patio & Bar"){
            BarImage.image = #imageLiteral(resourceName: "ArgusBuilding")
            let m_latitude = 39.7296
            let m_longitude = -121.8417
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
            
        //BELLAS
        else if(title == "Bella's Sports Pub"){
            BarImage.image = #imageLiteral(resourceName: "BellasBuilding")
            let m_latitude = 39.7298
            let m_longitude = -121.8418
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
            
        //DEFAULT
        else{
            let m_latitude = 39.7246
            let m_longitude = -121.8439
            let m_location = CLLocationCoordinate2D(latitude: m_latitude, longitude: m_longitude)
            return m_location
        }
    }
    
    //Initialize map with pin at bar location
    func MapViewInitializer(BarLocation: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegionMakeWithDistance(BarLocation,  400, 400)
        BarMap.setRegion(region, animated: true)
        BarMap.isScrollEnabled = false
        BarMap.isZoomEnabled = false
        BarMap.showsUserLocation = true
        
        pin.coordinate = BarLocation
        pin.title = name
        
        BarMap.addAnnotation(pin)
    }
    
    //Create the proper special to be displayed
    func SpecialsTextInitializer(){
        
        var todaysSpecial = String()
        
        //Sunday
        if(day == 1){
            SpecialsTitle.text = "Sunday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "Sunday Funday!\n" +
                "$5.00 Pitchers (Excluding Guinness)\n" +
                "$3.00 Bloody Mary's & Screwdrivers\n" +
                "Buck Night Hour 12 - 1 AM"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Burger Madness: Burger, & Fries/Salad for $5.99"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "Sunday Brunch 10 AM - 2 PM\n" +
                "Happy Hour 4 - 8 PM\n" +
                "10% Off for Students Until 8PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "No Specials Today"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"
            }
            else if(name == "Bellas Sports Pub"){
                
            }
            
        }
            
        //Monday
        else if(day == 2){
            SpecialsTitle.text = "Monday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "$5.00 Pitchers Domestic & Sierra Nevada"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Happy Hour 3 - 9PM\n" +
                "Beareoke 9PM - Close\n" +
                "Burger Madness: Burger, & Fries/Salad for $5.99"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "10% Off for Students Until 8 PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"
            }
        }
            
        //Tuesday
        else if(day == 3){
            SpecialsTitle.text = "Tuesday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "Buck Night 9 PM - 1 AM"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Wear A Bear Shirt and Get 50% Off Food and Drinks!\n" +
                "Happy Hour 3 - 9 PM"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "Happy Hour 4 - 8 PM\n" +
                "10% Off for Students Until 8PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"            }
        }
            
        //Wednesday
        else if(day == 4){
            SpecialsTitle.text = "Wednesday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "Half Off All Drinks 9PM - Close"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Trike Races at 10pm\n"
                + "Happy Hour 3 - 9PM"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "Happy Hour 4 - 8PM\n" +
                "10% Off for Students Until 8PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"
            }
        }
            
        //Thursday
        else if(day == 5){
            SpecialsTitle.text = "Thursday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "Power Hour: 25 Cent Well Drinks 9 - 10PM\n"
                + "$3.00 Monster Wells(10PM - 12AM)"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Happy Hour 3 - 8PM\n"
                + "Burger Madness: Burger, & Fries/Salad for $5.99"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "Happy Hour 4pm - 8pm\n" +
                "10% Off for Students Until 8PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "Music and Stein Night: Live Music and 5$ Sierra Nevada Steins"
            }
        }
            
        //Friday
        else if(day == 6){
            SpecialsTitle.text = "Friday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "All Teas $2.50 All Day & Night\n" +
                "$5.OO Pitchers of Well Drinks"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "Happy Hour 2 - 10 PM"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "10% Off for Students Until 8PM\n" +
                "Open to The Beach @ 9 PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"
            }
        }
        
        //Saturday
        else if(day == 7){
            SpecialsTitle.text = "Saturday's"
            if(name ==  "Rileys Bar & Grill"){
                todaysSpecial = "$2.50 Bartles & James Wine Coolers\n" +
                "$2.50 Coronas All Day & Night\n" +
                "$2.00 Double WellDrinks\n" +
                "$2.00 Bud Light & Coors Light Bottles"
            }
            else if(name == "Madison Bear Garden"){
                todaysSpecial = "No Specials Today"
            }
            else if(name == "Panama Bar Cafe"){
                todaysSpecial = "10% Off for Students Until 8 PM\n" +
                "Happy Hour 4 - 8 PM \n" +
                "Open to The Beach @ 9 PM"
            }
            else if(name == "Joes Bar"){
                todaysSpecial = "$2.75 Well Drinks, Draft Beers, Domestic Bottled Beers 11 AM - 6 PM"
            }
            else if(name == "Argus Patio & Bar"){
                todaysSpecial = "No Specials Today"
            }
        }
        
        SpecialsTitle.text = SpecialsTitle.text + " Specials"
        SpecialsText.text = todaysSpecial
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviewSegue" {
            let nextScene =  segue.destination as! ReviewViewController
            nextScene.name = name
            nextScene.userName = userName
        }
        else if segue.identifier == "DirectionsSegue"{
            let nextScene = segue.destination as! DirectionsViewController
            nextScene.BarLocation = BarLocation
            nextScene.name = name
            nextScene.userName = userName
        }
        else if segue.identifier == "back" {
            let nextScene = segue.destination as! SelectView
            nextScene.userName = userName
        }
    }

}




class DirectionsViewController: UIViewController,MKMapViewDelegate {
    
    var userName: String?
    var BarLocation: CLLocationCoordinate2D?
    var name: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var DirectionsLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(name == "Rileys Bar & Grill"){
            DirectionsLabel.text = "Directions to Rileys"
        }
        else if(name == "Madison Bear Garden"){
            DirectionsLabel.text = "Directions to The Bear"
        }
        else if(name == "Argus Patio & Bar"){
            DirectionsLabel.text = "Directions to Argus"
        }
        else if(name == "Panama Bar Cafe"){
            DirectionsLabel.text = "Directions to Panamas"
        }
        else if(name == "Joes Bar"){
            DirectionsLabel.text = "Directions to Joes"
        }
        
        mapView.delegate = self
        mapView.isZoomEnabled = true
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        
        let sourceLocation = CLLocationCoordinate2D(latitude: 39.7281, longitude: -121.8463)
        let destinationLocation = BarLocation
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation!, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Starting Location"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        if(name == "Rileys Bar & Grill"){
            destinationAnnotation.title = "Rileys"
        }
        else if(name == "Madison Bear Garden"){
            destinationAnnotation.title = "The Bear"
        }
        else if(name == "Argus Patio & Bar"){
            destinationAnnotation.title = "Argus"
        }
        else if(name == "Panama Bar Cafe"){
            destinationAnnotation.title = "Panamas"
        }
        else if(name == "Joes Bar"){
            destinationAnnotation.title = "Joe's"
        }
        
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )

        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene =  segue.destination as! BarViewController
        nextScene.name = name
        nextScene.userName = userName
    }

    
}


class ReviewViewController: UIViewController {
    
    var name: String?
    var userName: String?
    
    @IBOutlet weak var ReviewLabel: UILabel!
    
    @IBOutlet weak var ReviewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitializeText()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func InitializeText(){
        ReviewLabel.text = "Review " + name!
        
        ReviewText.layer.cornerRadius = 5
        ReviewText.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        ReviewText.layer.borderWidth = 0.5
        ReviewText.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene =  segue.destination as! BarViewController
        nextScene.name = name
        nextScene.userName = userName
    }
}








