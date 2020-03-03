//
//  RSSNetworkRouter.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import Alamofire

typealias RequestDefinition = (method: Alamofire.HTTPMethod,
    path: String,
    parameters: [String: AnyObject],
    body: Data?,
    encoding: ParameterEncoding)

enum RSSNetworkRouter: URLRequestConvertible {
    case getRSSList
    
    func asURLRequest() throws -> URLRequest {
        let requestDefinition = try self.requestDefinition()
        
        let url = try Constants.apiBaseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(requestDefinition.path))
        
        let encoding = requestDefinition.encoding
        urlRequest = try encoding.encode(urlRequest, with: requestDefinition.parameters)
        urlRequest.httpMethod = requestDefinition.method.rawValue
        
        if let body = requestDefinition.body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
    
    fileprivate func requestDefinition() throws -> (RequestDefinition) {
        let result: (method: Alamofire.HTTPMethod,
            path: String,
            parameters: [String: AnyObject],
            body: Data?,
            encoding: ParameterEncoding) = {
                switch self {
                case .getRSSList:
                    let path = "feed/rss"
                    return (.get, path, [:], nil, URLEncoding.default)
                }
        }()
        return result
    }
}
