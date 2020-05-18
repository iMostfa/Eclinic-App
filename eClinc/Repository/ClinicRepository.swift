//
//  ClincRepository.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine
/// Any Repository for the app, have to Confirm to this protocol, and override the default implemention
protocol ClinicRepository {
  func fetchClincs() -> AnyPublisher<Clinic, EClincError>
  func fetchDoctors(for clinc: Clinic) -> AnyPublisher<Doctor, EClincError>
  func fetchSlots(for doctor: Doctor, day: AvailableDay) ->  AnyPublisher<AvailableSlot, EClincError>
}

//This default implemtnion is used when one of the Repositoriers didn't implement the  needed function
extension ClinicRepository {

  func fetchClincs() -> AnyPublisher<Clinic, EClincError> {
    return [Clinic]()
    .publisher
    .mapError(mapNever)
    .eraseToAnyPublisher()
  }

  func fetchDoctors(for clinc: Clinic) -> AnyPublisher<Doctor, EClincError> {
    return [Doctor]()
    .publisher
    .mapError(mapNever)
    .eraseToAnyPublisher()
  }

  func fetchSlots(for doctor: Doctor, day: AvailableDay) ->  AnyPublisher<AvailableSlot, EClincError> {
    return [AvailableSlot]()
      .publisher
    .mapError(mapNever)
    .eraseToAnyPublisher()
  }
}
