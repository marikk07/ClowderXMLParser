//
//  RSSProvider.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import Alamofire
import SwiftyXMLParser

protocol RSSProviderProtocol {
    func getRSSList(success: @escaping([RSSItem]) -> Void, errorHandler: @escaping(Error) -> Void)
}

class RSSProvider: RSSProviderProtocol {
    let manager = SessionManager()
    
    func getRSSList(success: @escaping([RSSItem]) -> Void, errorHandler: @escaping(Error) -> Void) {
        manager.request(RSSNetworkRouter.getRSSList).responseData { response in
            switch response.result {
            case .success(let data):
                let xml = XML.parse(data)
                let path = ["rss", "channel"]
                let channel = xml[path]
                
                let array = channel.element?.childElements.compactMap({$0}).filter({$0.name == "item"}) ?? []
                let rssArray = array.compactMap({RSSItem(element: $0)})
                
                success(rssArray)
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
}
