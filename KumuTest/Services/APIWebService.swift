//
//  APIWebService.swift
//  KumuTest
//
//  Created by Franz Henri De Guzman on 7/14/21.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

struct APIWebService {
    /**
     Create request.
     - Returns URLRequest
     */
    static func createRequest(
        method: Alamofire.HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        jsonObject: Any? = nil,
        timeout: TimeInterval? = nil
    ) throws -> URLRequest
    {
        var mutableURLRequest: NSMutableURLRequest!
        
        let url = try APIEndpoint.BASE_URL.asURL()
        mutableURLRequest = NSMutableURLRequest(url: url.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue
        
        if let timeout = timeout {
            mutableURLRequest.timeoutInterval = timeout
        }
        
        if method == .get {
            return try URLEncoding.default.encode(mutableURLRequest as URLRequest, with: parameters)
        } else {
            if let jsonObj = jsonObject {
                return try JSONEncoding.default.encode(mutableURLRequest as URLRequest, withJSONObject: jsonObj)
            } else {
                return try JSONEncoding.default.encode(mutableURLRequest as URLRequest, with: parameters)
            }
        }
    }
}
