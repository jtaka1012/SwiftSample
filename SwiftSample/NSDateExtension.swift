//
//  
//  NSDateExtension.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/04/29.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation

public extension NSDate {
    public class func stringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.stringFromDate(date)
    }
    
    public class func dateFromString(sDate: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.dateFromString(sDate)!
    }
}