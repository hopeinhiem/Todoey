//
//  Items.swift
//  Todoey
//
//  Created by Andrew Greene on 2018-10-24.
//  Copyright © 2018 Andrew Greene. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCatagory = LinkingObjects(fromType: Catagory.self, property: "items")
}
