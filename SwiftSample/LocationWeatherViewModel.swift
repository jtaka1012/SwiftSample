//
//  LocationWeatherViewModel.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import UIKit

protocol LocationWeatherViewModelDelegate {
    func completionRefreshWeatherData() -> Void
}

class LocationWeatherViewModel:LDWeatherManagerDelegate {
 
    var delegate:LocationWeatherViewModelDelegate?
    var location : WeatherLocation!
    var locationWeathers:[WeatherData] = []
    var cityId = ""
    let ldwm = LDWeatherManager()
    
    init (cityId:String){
    
        self.cityId = cityId
        self.location = WeatherLocationManager.show(cityId)
        
        ldwm.delegate = self
        // IDに応じた天気情報の取得
        locationWeathers = WeatherDataManager.indexWithCityId(cityId)!
    }
    
    var title:String?{
        get{
            // cityIDから都市の名前を取得する
            let wl = WeatherLocationManager.show(cityId)
            return wl?.city
        }
    }
    
//    var locationWeathers:[WeatherData]?{
//        get{
//            
//        }
//    }

    var sectionCount:Int{
        get{
            return 1
        }
    }
    
    var rowCount:Int{
        get{
            return locationWeathers.count
        }
    }

    func weatherDate(indexPath:NSIndexPath) -> String? {
        
        let wl = locationWeathers[indexPath.row]
        return NSDate.stringFromDate(wl.date!)
    }
    
    func weatherIcon(indexPath:NSIndexPath) -> UIImage? {

        let wl = locationWeathers[indexPath.row]
        let sUrl = wl.imageUrl
        
        let url = NSURL(string: sUrl!);
        let imgData: NSData?

        do {
            imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let img = UIImage(data:imgData!);
            
            return img

        } catch {
            print("Error: can't create image.")
            return nil
        }

    }
    
    func weatherDescription(indexPath:NSIndexPath) -> String? {

        if locationWeathers.count == 0 {
            return nil
        }
        
        let wl = locationWeathers[indexPath.row]
        return wl.weatherText
    }
    
    // 最新の天気の情報を取得する
    func refreshWeatherData()->Bool{
        
        var resp = true
        
        let param = LDWeatherData()
        param.cityID = cityId
        let params:Array = [param]
        
        
        if !ldwm.getWeatherData(params) {
            print("取得できませんでした")
            resp = false
        }
        
        return resp
    }

    // delegate
    func completionGetWeatherData(ldwDataArray:[LDWeatherData]) -> Void{
        
        // 取得した天気データを格納
        for ldwd in ldwDataArray{
            WeatherDataManager.insertUpdateWithLDWeatherData(ldwd)
        }
            
        // 変数に再格納
        if let locationWeathers = WeatherDataManager.indexWithCityId(cityId){
            self.locationWeathers = locationWeathers
        }else{
            locationWeathers = []
        }
        
        // delegate先に通知する
        delegate?.completionRefreshWeatherData()
    }

}