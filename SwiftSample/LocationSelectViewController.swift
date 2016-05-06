//
//  LocationSelectViewController.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/05/04.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import UIKit

class LocationSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblLocation: UITableView!
    
    private var locations:[WeatherLocation] = []
    private var selectLocation:WeatherLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = WeatherLocationManager.index()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let wl = locations[indexPath.row]
        let lDate = cell.viewWithTag(1) as! UILabel
        
        lDate.text = wl.city

        return cell
    }
    
    // delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectLocation = locations[indexPath.row]
        performSegueWithIdentifier("locationWeatherSegue",sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "locationWeatherSegue" {
        
            let lwvc = segue.destinationViewController as! LocationWeatherViewController
            lwvc.location = selectLocation
            
        }
    }
    
}
