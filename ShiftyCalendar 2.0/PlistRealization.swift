//
//  PlistRealization.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 10/5/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import Foundation


//    MARK: - plist variable
public var plistURL: URL {
        let documentDirectoryURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent("Event.plist")
    }


//    MARK: - plist save and load methods
public func savePropertyList(_ plist: Any) throws {
    let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
    try plistData.write(to: plistURL)
    
}

public func loadPropertyList() throws -> [String:Any] {
    let data = try Data(contentsOf: plistURL)
    guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any] else  { return [String:Any]() }
    return plist
    
}
