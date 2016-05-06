//
//  LocationWeatherViewController.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import UIKit

class LocationWeatherViewController: UIViewController,LocationWeatherViewModelDelegate {

    var location:WeatherLocation?
    var lwvm : LocationWeatherViewModel!
    var rc: UIRefreshControl!
    //var locationWeathers:[WeatherLocation] = []
    
    @IBOutlet weak var tblWeather: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lwvm = LocationWeatherViewModel.init(cityId: location!.id)
        lwvm.delegate = self
        
        rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Loading New Weather Data")
        
        // 更新が始まった時の処理の指定
        rc.addTarget(self, action: #selector(LocationWeatherViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        
        tblWeather.addSubview(rc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lwvm?.rowCount)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let lDate = cell.viewWithTag(1) as! UILabel
        let ivWeather = cell.viewWithTag(2) as! UIImageView
        let lWeatherDesc = cell.viewWithTag(3) as! UILabel
        
        lDate.text = lwvm!.weatherDate(indexPath)
        ivWeather.image = lwvm!.weatherIcon(indexPath)
        lWeatherDesc.text = lwvm!.weatherDescription(indexPath)
        
        return cell
    }
    
    // delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tblWeather.reloadData()
    }

    
    func refresh() {
        lwvm.refreshWeatherData()
    }
    
    func completionRefreshWeatherData(){
        rc.endRefreshing()
        tblWeather.reloadData()
    }
}
