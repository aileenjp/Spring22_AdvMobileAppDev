//
//  Grocery.swift
//  GroceryRealm
//
//  Created by Aileen Pierce
//

import Foundation
import RealmSwift

class Grocery: Object {
    @Persisted(primaryKey: true) var _id = ObjectId.generate()
    @Persisted var name = ""
    @Persisted var bought = false
}

