//
//  Person.swift
//  SWPersons
//
//  Created by Никита Главацкий on 04.12.2019.
//  Copyright © 2019 StreetPeople. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object{
    @objc dynamic var name = ""
    @objc dynamic var height = 0
    @objc dynamic var mass = 0
    @objc dynamic var hairColor = ""
    @objc dynamic var skinColor = ""
    @objc dynamic var eyeColor = ""
    @objc dynamic var birthYear = ""
    @objc dynamic var gender = ""
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    
}
