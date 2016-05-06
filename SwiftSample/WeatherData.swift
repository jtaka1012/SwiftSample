//
//  WeatherData.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/01.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object{
    
    dynamic var id = NSUUID().UUIDString
    dynamic var creatTime : NSDate?
    dynamic var updateTime : NSDate?
    dynamic var cityID = ""
    dynamic var weatherText : String?
    dynamic var imageUrl : String?
    dynamic var date : NSDate?
    dynamic var publicTime : String?
    
    let locations = LinkingObjects(fromType: WeatherLocation.self, property: "weathers")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
