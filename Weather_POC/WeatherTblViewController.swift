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

class WeatherTblViewController: UITableViewController {
    
    var placeWeathers : [PlaceWeather]? = nil
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        
        
        if  self.placeWeathers == nil || self.placeWeathers?.count == 0
        {
            
            if NetworkReachabilityManager()?.isReachable == true{
                self.showLoader()
                WebAPI.shared.loadWeather(lattitude: 0, longitude: 0, completionhandeler: { (weathers, isLoaded) in
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUp(){
        
        let className = ItemTblCell.identifier
        self.tableView.register(UINib.init(nibName:className, bundle: nil), forCellReuseIdentifier:className )
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 88
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
