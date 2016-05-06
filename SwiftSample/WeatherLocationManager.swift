//
//  WeatherLocationManager.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherLocationManager {
    
    private static let realm = try! Realm()
    
    // index
    class func index() -> Array<WeatherLocation>{
        let wlArray = realm.objects(WeatherLocation)
        return Array(wlArray)
    }
    
    // create
    
    // show
    class func show(id:String) -> WeatherLocation?{
        let predicate = NSPredicate(format: "id = %@", id)
        let wlArray = realm.objects(WeatherLocation).filter(predicate)
        
        if let wl = wlArray.first{
            return wl
        }
        
        return nil
    }
        
    // insert
    class func insert(wlData:WeatherLocation) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.add(wlData, update: false)
            }
        }catch {
            resp = false
        }
        
        return resp
    }
    

    
    
    // update
    class func update(wlData:WeatherLocation) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.add(wlData, update: true)
            }
        }catch {
            resp = false
        }
        
        return resp
    }

    // destroy
    class func destroy(wlData:WeatherLocation) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.delete(wlData)
            }
        }catch {
            resp = false
        }
        
        return resp
    }
}