//
//  Category.swift
//  ToDo
//
//  Created by Nhu Luong on 1/5/18.
//  Copyright © 2018 Nhu Luong. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>() 
}
