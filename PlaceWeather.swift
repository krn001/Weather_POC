//
//  PlaceWeather.swift
//  Weather_POC
//
//  Created by mac on 01/04/19.
//  Copyright © 2019 kiranJuware. All rights reserved.
//

import Foundation

// this class can be updated for more flexible resonse

class  PlaceWeather{
    
    var  placeName = String()
    var temperature = Float(0)
    var humidity = Float(0)

    init() {
        
    }
     init(placeName: String, temperature: Float, humidity:Float){
        
        self.placeName = placeName
        self.temperature = temperature
        self.humidity = humidity
        
        
    }
    
}
