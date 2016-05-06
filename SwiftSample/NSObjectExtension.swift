//
//
//  NSObjectExtension.swift
//  SwiftSample
//
//  Created by Jun Takahashi on 2016/04/29.
//  Copyright © 2016年 Jun Takahashi. All rights reserved.
//

import Foundation

/** protocols **/
protocol PropertyNames {
    func propertyNames() -> [String]
}


/** extensions **/
extension PropertyNames
{
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
}