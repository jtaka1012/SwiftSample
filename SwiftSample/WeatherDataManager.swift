//
//  WeatherDataManager.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherDataManager {
    
    private static let realm = try! Realm()
    
    // index
    class func index() -> Array<WeatherData>{
        let wdArray = realm.objects(WeatherData)
        return Array(wdArray)
    }
    
    class func indexWithCityId(cityId:String) -> Array<WeatherData>? {
        
        let predicate = NSPredicate(format: "id = %@", cityId)
        let wlArray = realm.objects(WeatherLocation).filter(predicate)
        
        if let wl = wlArray.first{
            return Array(wl.weathers)
        }else{
            return nil
        }
    }
    
    // create
    
    // show
    class func show(id:String) -> WeatherData?{
        let predicate = NSPredicate(format: "id = %@", id)
        let wdArray = realm.objects(WeatherData).filter(predicate)
        
        if let wd = wdArray.first{
            return wd
        }
        
        return nil
    }
    
    class func showWithCityId(cityID:String, date:NSDate) -> WeatherData? {
        
        // realmにレコードが登録されているかチェック
        let predicate = NSPredicate(format: "cityID = %@ AND date = %@", cityID, date)
        let wdArray = realm.objects(WeatherData).filter(predicate)
        
        let wd : WeatherData?
        if wdArray.isEmpty {
            wd = nil
        }else{
            wd = wdArray.first! // 更新
        }
        
        return wd
    }
    
    // insert
    class func insert(wdData:WeatherData) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.add(wdData, update: false)
            }
        }catch {
            resp = false
        }
        
        return resp
    }
    
    // update
    class func update(wdData:WeatherData) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.add(wdData, update: true)
            }
        }catch {
            resp = false
        }
        
        return resp
    }
    
    // destroy
    class func destroy(wdData:WeatherData) -> Bool{
        
        var resp = true
        
        do {
            try realm.write {
                realm.delete(wdData)
            }
        }catch {
            resp = false
        }
        
        return resp
    }
    
    // insert Or Update With LDWeatherData
    class func insertUpdateWithLDWeatherData(ldwd:LDWeatherData){
        
        let predicate = NSPredicate(format: "cityID = %@ AND date = %@", ldwd.cityID, ldwd.date!)
        let wdArray = realm.objects(WeatherData).filter(predicate)
        
        let wd : WeatherData
        if wdArray.isEmpty {
            wd = WeatherData()  // 新規追加
        }else{
            wd = wdArray.first! // 更新
        }
        
        // locationの取得
        let location = WeatherLocationManager.show(ldwd.cityID)
        
        try! realm.write {
            wd.updateTime = NSDate()
            wd.cityID = ldwd.cityID
            wd.weatherText = ldwd.weatherText
            wd.imageUrl = ldwd.imageUrl
            wd.date = ldwd.date
            wd.publicTime = ldwd.publicTime
            
            realm.add(wd, update: true)
        }
        
        //ここで中にidが同じデータが含まれていないかチェック
        var isSetted = false
        var settedIndex:Int = 0
        let weathers = Array(location!.weathers)
        for lwd:WeatherData in Array(weathers) {
            if lwd.id == wd.id {
                isSetted = true
                break
            }
            settedIndex = settedIndex + 1
        }
        
        try! realm.write {
            if isSetted {
                location!.weathers.replace(settedIndex, object: wd)
            }else{
                location!.weathers.append(wd)
            }
        }
    }
}