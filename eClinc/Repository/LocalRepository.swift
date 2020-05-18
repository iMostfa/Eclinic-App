//
//  LocalRepository.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine

class LocalRepository: ClinicRepository {

  func fetchClincs() -> AnyPublisher<Clinic, EClincError> {
    [
      Clinic(id: 0, name: "Respiratory Problems", image: ""),
      Clinic(id: 1, name: "Dental Problems", image: ""),
      Clinic(id: 2, name: "Vision Problems", image: ""),
      Clinic(id: 3, name: "Dental Problems", image: "")
      ]
      .publisher
      .mapError(mapNever)
      .eraseToAnyPublisher()
  }

  func fetchDoctors(for clinc: Clinic) -> AnyPublisher<Doctor, EClincError> {
    [
      Doctor(id: 0,
             name: "Khalid Youssef",
             image: "",
             description: "isThe best Doctor in the world for being helpfulenought for the rest of world, enought for the rest of world",
             location: "Egypt", rating: "4.5", daysAvilable: ["Sat", "Sun", "Wed"]),
      Doctor(id: 1,
             name: "Elblasy Mohammed",
             image: "",
             description: "isThe best Doctor in the world for being helpful enought for the rest of world",
             location: "Egypt", rating: "4.5",
             daysAvilable: ["Sat", "Sun", "Wed"]),
      Doctor(id: 2,
             name: "Ayah Mohsen",
             image: "",
             description: "isThe best Doctor in the world for being helpful enought for the rest of world",
             location: "Egypt", rating: "2.5",
             daysAvilable: ["Mon", "Tue", "Wed"]),
      Doctor(id: 3,
             name: "Ayah Mohsen",
             image: "",
             description: "for the rest of world isThe best Doctor in the world for being helpful enought ",
             location: "Egypt", rating: "2.5",
        daysAvilable: ["Mon", "Tue", "Wed"]),
      Doctor(id: 4,
             name: "Memo Mohsen",
             image: "",
             description: "for the rest of world isThe best Doctor in the world for being helpful enought ",
             location: "Egypt", rating: "2.5",
             daysAvilable: ["Mon", "Tue", "Wed"])

      ]
      .publisher
      .mapError(mapNever)
      .eraseToAnyPublisher()
  }

  func fetchSlots(for doctor: Doctor, day: AvailableDay) -> AnyPublisher<AvailableSlot, EClincError> {
    [AvailableSlot(id: 0, time: "9:00 PM"),
     AvailableSlot(id: 1, time: "10:30 PM"),
     AvailableSlot(id: 2, time: "12:30 PM"),
     AvailableSlot(id: 3, time: "1:30 PM"),
     AvailableSlot(id: 4, time: "2:30 PM"),
     AvailableSlot(id: 5, time: "3:30 PM")
      ]
      .publisher
      .mapError(mapNever)
      .eraseToAnyPublisher()
  }
}
