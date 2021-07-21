//
//  APIRouter.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

// ***  This router class is responsible for creating
// ***  a request that is specific to the app in general

import Foundation
import Alamofire
import RxAlamofire
import SwiftyJSON


enum APIRouter: URLRequestConvertible {
    
    case searchItunes(String, String, String)
    
    func asURLRequest() throws -> URLRequest {
        let req: (method: Alamofire.HTTPMethod, path: String, parameters: Parameters?, jsonSerializableObj: Any?) = {
            switch self {
            case let .searchItunes(term, country, mediaType):
                return (.get, "search", ["term": term, "country": country, "media": mediaType], nil)
            }
        }()
        
        if let jsonObject = req.jsonSerializableObj {
            return try APIWebService.createRequest(method: req.method, path: req.path, parameters: nil, jsonObject: jsonObject)
        } else {
            return try APIWebService.createRequest(method: req.method, path: req.path, parameters: req.parameters)
        }
    }
}
