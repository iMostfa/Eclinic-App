//
//  AppointmentViewModel.swift
//  eClinc
//
//  Created by mostfa on 5/20/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class AppointmentViewModel: ObservableObject {

  @Published var doctor: Doctor
  @Published var availableSlots: [AvailableSlot] = []
  @Published var avaliableCards = ["Fawry",
                                   " Pay",
                                   "Mada",
                                   "Visa"]
  @Published var availableDays: [AvailableDay] = []

  private var repository: ClinicRepository
  private var anyCancellables = Set<AnyCancellable>()
  init(doctor: Doctor, _ repository: ClinicRepository) {
    self.repository = repository
    self.doctor = doctor
  }

  func fetchSlots(for day: AvailableDay) {

    repository
      .fetchSlots(for: doctor, day: day)
      .sink(receiveCompletion: hadleCompletion) { (slot) in
        self.availableSlots.append(slot)
    }
    .store(in: &anyCancellables)

  }

  func fetchDays() {
    repository
      .fetchDays(for: doctor)
      .sink(receiveCompletion: hadleCompletion) { (day) in
        self.availableDays.append(day)
    }
  .store(in: &anyCancellables)

  }

}
