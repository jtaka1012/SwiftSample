//
//  AppDelegate.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/04/26.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // realmのマイグレーション処理
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        // 都市のデータを登録
        var locations:Array<WeatherLocation> = []
        
        let sapporo = WeatherLocation()
        sapporo.city = "札幌"
        sapporo.id = "016010"
        locations.append(sapporo)
        
        let sendai = WeatherLocation()
        sendai.city = "仙台"
        sendai.id = "040010"
        locations.append(sendai)
        
        let tokyo = WeatherLocation()
        tokyo.city = "東京"
        tokyo.id = "130010"
        locations.append(tokyo)
        
        for wl in locations{
            // realmにレコードが登録されているかチェック
            let realm = try! Realm()
            
            let predicate = NSPredicate(format: "id = %@", wl.id)
            let wlArray = realm.objects(WeatherLocation).filter(predicate)
            
            if wlArray.isEmpty {
                try! realm.write {
                    // 新規追加
                    realm.add(wl, update: true)
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

