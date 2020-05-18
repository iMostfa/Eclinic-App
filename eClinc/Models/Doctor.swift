//
//  Doctor.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation

/// This class represent Doctor
/// - Parameter name: `name` Name of the doctor.
/// - Parameter description: `description` description of the doctor.
/// - Parameter description: `Image` image of the doctor, likely url?.
/// - Parameter location: `location` location of the doctor.
/// - Parameter rating: `rating` rating of the doctor.
/// - Parameter daysAvilable: `daysAvilable` the days the doctor available in.
struct Doctor: Identifiable {
  var id: Int
  var name: String
  var image: String
  var description: String
  var location: String
  var rating: String
  var daysAvilable: [String]

}
