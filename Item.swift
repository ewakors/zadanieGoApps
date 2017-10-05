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

class Item: MyJSONProtocol {
    typealias T = Item
    
    static let itemField = "items"
    static let itemIdField = "id"
    static let itemTitleField = "title"
    static let itemSubtitleField = "subtitle"
    static let itemThumbField = "thumb"
    static let itemColorField = "color"
    
    static let identifier = "cell"
    
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
    var backgroundColor: UIColor {
        if color == "red" {
            return UIColor.red
        }
        return UIColor.blue
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
            
            print(i.title)

            result.append(Item(json: item))
        }

        return result
    }
}
