//
//  WeatherTblViewController.swift
//  Weather_POC
//
//  Created by mac on 01/04/19.
//  Copyright © 2019 kiranJuware. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import CoreLocation

class WeatherTblViewController: UITableViewController {
    
    var placeWeathers : [PlaceWeather]? = nil
    var locationManager:CLLocationManager!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        
        
      
            
        
            
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUp(){
        let className = ItemTblCell.identifier
        self.tableView.register(UINib.init(nibName:className, bundle: nil), forCellReuseIdentifier:className )
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 88
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setUpLocation()
       
        
    }
    
    func setUpLocation(){
        
        if locationManager == nil{
            
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }else{
                print("Redirect here to enable service")
            }
        }
       
    }
    
    func loadWeatherFor(location: CLLocation){
        
        // if you dont want to refresh
        if NetworkReachabilityManager()?.isReachable == true{
            self.showLoader()
            WebAPI.shared.loadWeather(lattitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completionhandeler: { (weathers, isLoaded) in
                self.hideLoader()
                if weathers != nil{
                    
                    self.placeWeathers = weathers as! [PlaceWeather]?
                    self.tableView.reloadData()
                }
                
            })
        }else{
            print("no network")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension WeatherTblViewController: CLLocationManagerDelegate{
    
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("device latitude = \(userLocation.coordinate.latitude)")
        print("device longitude = \(userLocation.coordinate.longitude)")
        
        if self.placeWeathers == nil || self.placeWeathers?.count == 0 // to update frequently , you can exclude this condtion
        {
            self.loadWeatherFor(location: userLocation)

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}

extension WeatherTblViewController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let placeWeathers = self.placeWeathers{
            return placeWeathers.count
        }
        return 0
    }
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
  override  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTblCell.identifier, for: indexPath) as! ItemTblCell
        cell.selectionStyle = .none
        
        if let weather = self.placeWeathers?[indexPath.row] {
            
            cell.setData(weather)
        }
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
}

extension UIViewController{
    
    func showLoader(){
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.show()
    }
    
    func hideLoader(){
        
        SVProgressHUD.dismiss()
    }
    
    
}
