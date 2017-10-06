//
//  Item.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum BacgroundCellColor: String {
    case Red = "red"
    case Blue = "blue"
    case Green = "green"
}

class Item: MyJSONProtocol {
    typealias T = Item
    
    static let itemField = "items"
    static let itemIdField = "id"
    static let itemTitleField = "title"
    static let itemSubtitleField = "subtitle"
    static let itemThumbField = "thumb"
    static let itemColorField = "color"
    
    static let identifier = "cell"
    static let itemDetailsSequage = "itemDetailsSegue"
    static let itemShowDetailsSeguage = "itemShowDetails"
    
    private var id: Int
    private var title: String
    private var subtitle: String
    private var thumb: String
    private var color: String
    
    init(json: JSON) {
        id = 0
        title = ""
        subtitle = ""
        thumb = ""
        color = ""
        
        fromJSON(json: json)
    }
    
    func getId() -> Int {
        return id
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getSubtitle() -> String {
        return subtitle
    }
    
    func getThumb() -> String {
        return thumb
    }
    
    func getColor() -> String {
        return color
    }
    
    func backgroundColor() -> UIColor {
        
        if color == BacgroundCellColor.Red.rawValue {
            return UIColor.red
        } else if color == BacgroundCellColor.Blue.rawValue {
            return UIColor.blue
        } else if color == BacgroundCellColor.Green.rawValue{
            return UIColor.green
        } else {
            return UIColor.clear
        }
    }
    
    func fromJSON(json: JSON) {
        self.id = json[Item.itemIdField].intValue
        self.title = json[Item.itemTitleField].stringValue
        self.subtitle = json[Item.itemSubtitleField].stringValue
        self.thumb = json[Item.itemThumbField].stringValue
        self.color = json[Item.itemColorField].stringValue
    }
    
    static func arrayFromJSON(json: JSON) -> [Item] {
        var result = [Item]()
        let i: Item = Item(json: json)
        
        for item in json[Item.itemField].arrayValue {
            
            i.id = item[Item.itemIdField].intValue
            i.title = item[Item.itemTitleField].stringValue
            i.subtitle = item[Item.itemSubtitleField].stringValue
            i.thumb = item[Item.itemThumbField].stringValue
            i.color = item[Item.itemColorField].stringValue
            
            print(i.color)

            result.append(Item(json: item))
        }

        return result
    }
}
