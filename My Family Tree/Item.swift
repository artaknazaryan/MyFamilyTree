//
//  Item.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
