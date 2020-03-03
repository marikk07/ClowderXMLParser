//
//  RSSItem.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct RSSItem {
    var title: String
    var link: String
    var description: String
    var icon: String?
    
    init(element: XML.Element) {
        title = element.childElements.filter({$0.name == "title"}).first?.text ?? ""
        link = element.childElements.filter({$0.name == "link"}).first?.text ?? ""
        description = element.childElements.filter({$0.name == "description"}).first?.text ?? ""
        icon = element.childElements.filter({$0.name == "media:thumbnail"}).first?.attributes["url"]
    }
}

