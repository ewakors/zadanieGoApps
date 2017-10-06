//
//  Router.swift
//  projekt
//
//  Created by Ewa Korszaczuk on 05.10.2017.
//  Copyright © 2017 Ewa Korszaczuk. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://test.goapps.vipserv.org/"
    static let token = "SUPERSECRETACCESSTOKEN"
    
    case getItems(page: Int, count: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getItems:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getItems:
            return "index.php"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch self {
        case .getItems(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["page": parameters.page, "count": parameters.count])
        }
        return urlRequest
    }
}
