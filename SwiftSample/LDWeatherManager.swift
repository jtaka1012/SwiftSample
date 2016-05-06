//
//  LDWeatherManager.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation
import Alamofire

protocol LDWeatherManagerDelegate {
    func completionGetWeatherData(ldwDataArray:[LDWeatherData]) -> Void
}

class LDWeatherData: NSObject, PropertyNames {
    
    var cityID = ""
    var weatherText : String?
    var imageUrl : String?
    var date : NSDate?
    var publicTime : String?
    
}

class LDWeatherManager {
    
    var delegate : LDWeatherManagerDelegate?
    private var count = 0
    private var isConnecting = false
    private var ldwDataArray:[LDWeatherData] = []
    
    final private let baseUrl = "http://weather.livedoor.com/forecast/webservice/json/v1?city="
    
    // livedoor Weatherより天気情報を取得する
    func getWeatherData(weatherDataArray:[LDWeatherData]) -> Bool{
        
        // 通信中の場合はfalseで折り返す
        if isConnecting {
            return false
        }
        
        isConnecting = true
        ldwDataArray = []
        count = weatherDataArray.count
        
        for weatherData in weatherDataArray{
            
            let url = baseUrl + weatherData.cityID
            
            Alamofire.request(.GET, url)
                .responseJSON { response in
                    
                    if let jsonDic = response.result.value as? NSDictionary,
                        let forcastsArray = jsonDic["forecasts"] as? NSArray{
                        
                        for weather in forcastsArray{
                            
                            let image = weather["image"] as! NSDictionary
                            let ldwd = LDWeatherData()
                            ldwd.cityID = weatherData.cityID
                            ldwd.weatherText = weather["telop"] as? String
                            ldwd.imageUrl = image["url"] as? String
                            
                            let date = NSDate.dateFromString(weather["date"] as! String)
                            ldwd.date = date
                            
                            ldwd.publicTime = jsonDic["publicTime"] as? String
                            
                            
                            // データをArrayに格納
                            self.ldwDataArray.append(ldwd)
                        }
                    }
                    
                    self.noticeForDelegate(self.ldwDataArray)
            }
        }
        
        return true
    }

    // 全ての通信が完了していた場合、delegate先に完了を通知する
    private func noticeForDelegate(ldwDataArray:[LDWeatherData]){
        count = count - 1
        print(count)
        if count <= 0 {
            isConnecting = false
            self.delegate?.completionGetWeatherData(ldwDataArray)
        }
    }
}
