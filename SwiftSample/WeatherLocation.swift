//
//  WeatherLocation.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherLocation: Object {
    
    dynamic var city = ""
    dynamic var id = ""
    let weathers = List<WeatherData>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
