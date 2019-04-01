//
//  WebAPI.swift
//  Weather_POC
//
//  Created by mac on 01/04/19.
//  Copyright © 2019 kiranJuware. All rights reserved.
//

import Foundation
import Alamofire

class WebAPI{
    
    static let shared = WebAPI()
     let apiKey = "7297b9f2a0b640d197095ea13fc53aac"
    let baseURL = "http://api.openweathermap.org/data/2.5/find?"

    private  init(){
        
        
    }
    
    
    func weatherUrlWith(lattitude: Double, longitude: Double, key: String)-> String{
        
        return baseURL + "lat=\(lattitude)&lon=\(longitude)&cnt=10&appid=" + apiKey
    }

    func loadWeather(lattitude: Double, longitude: Double , completionhandeler: @escaping (_ objects: Any? , _ isLoaded: Bool?)->())
    {
       
        let url = self.weatherUrlWith(lattitude:lattitude , longitude: longitude, key: apiKey)
        
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding(), headers: headers).responseJSON {
            
            (responseData:DataResponse<Any>?)   in  // make optional
            if let response = responseData   // check if not nil
            {
                switch(response.result) {
                case .success:
                    if(response.response?.statusCode == 200){
                        
                        if let data = response.result.value as? [String: Any] // check if Array type
                        {
                            
                            print(data)
                            let objs = JSonFormatter .objectsFromWetherJSON(dicn: data)
                            
                            completionhandeler(objs, true )
                        }
                        else
                        {
                            completionhandeler(nil,false )
                        }
                        
                        
                    }else{
                        completionhandeler(nil,false )
                    }
                    
                    
                        
                        
                    
                    
                case .failure:
                    completionhandeler(nil,false )
                    
                    
                }
            }
            else
            {
                completionhandeler(nil,false )
            }
            
        }
    }
    
}

class  JSonFormatter{
    
   static func objectsFromWetherJSON(dicn: [String:Any]) -> [PlaceWeather]
    {
        
        var weathers = [PlaceWeather]()
        
        if let list = dicn["list"] as? [[String:Any]]{
            for weatherDicn in list{
                
                if let main = weatherDicn["main"] as? [String:Any]{
                    
                    
                    if let name = weatherDicn["name"] as? String, let temp = main["temp"] as? Float, let humidity = main["humidity"] as? Float{
                        
                        let   place = PlaceWeather.init(placeName: name, temperature: temp, humidity: humidity)
                        
                        weathers.append(place)
                    }
                }
                
               
                
                
                
            }
            
        }
       
        return weathers
        
        
        
    }
}
