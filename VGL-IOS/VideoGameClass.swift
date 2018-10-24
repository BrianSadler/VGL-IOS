//
//  VideoGameClass.swift
//  VGL-IOS
//
//  Created by Brian Sadler on 10/16/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import Foundation
import RealmSwift


class VideoGame: Object {
   @objc dynamic var title: String = ""
    @objc dynamic var genre: String = ""
      @objc dynamic var rating: String = ""
     @objc dynamic var gameDescription: String = ""
    @objc dynamic var checkedIn:Bool = true
      @objc dynamic var dueDate: Date? = nil
 
    }


