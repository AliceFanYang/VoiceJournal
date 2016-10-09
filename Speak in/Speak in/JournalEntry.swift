//
//  JournalEntry.swift
//  Speak in
//
//  Created by Alice Yang on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import RealmSwift

class JournalEntry: Object {
    dynamic var id = ""
    dynamic var anger = Float()
    dynamic var joy = Float()
    dynamic var fear = Float()
    dynamic var sadness = Float()
    dynamic var surprise = Float()
    dynamic var entryText = ""
    dynamic var entryTitle = ""
    dynamic var date = NSDate()
    
    //dynamic var sound = NSData()?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
