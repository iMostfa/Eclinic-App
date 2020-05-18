//
//  AvailableSlot.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation

/// A class represent one available Slot for selected day
struct AvailableSlot: Identifiable {
  var id: Int
  var time: String
  //TODO: adding computed property, to compute the date, with selected time to this file
}
