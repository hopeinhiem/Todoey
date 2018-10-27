//
//  Catagory.swift
//  Todoey
//
//  Created by Andrew Greene on 2018-10-24.
//  Copyright © 2018 Andrew Greene. All rights reserved.
//

import Foundation
import RealmSwift

class Catagory: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var cellColor : String = ""
    let items = List<Item>()
}
