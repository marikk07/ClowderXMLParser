//
//  SwinjectStoryboard.swift
//  ClowderXMLParser
//
//  Created by Maryan on 03.03.2020.
//  Copyright © 2020 Marian. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
     class func setup() {
        defaultContainer.register(RSSProvider.self) { r in
            let repoProvider = RSSProvider()
            return repoProvider
        }.inObjectScope(.container)
        
        defaultContainer.storyboardInitCompleted(RSSListController.self) { r, c in
            c.dataProvider = r.resolve(RSSProvider.self)
        }
    }
}
