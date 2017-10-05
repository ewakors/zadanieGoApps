//
//  MyJSONProtocol.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MyJSONProtocol {
    associatedtype T
    
    func fromJSON(json: JSON)
}
