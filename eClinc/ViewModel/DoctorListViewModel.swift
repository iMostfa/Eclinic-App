//
//DoctorListViewModel.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class DoctorListViewModel: ObservableObject {
  var repository: ClinicRepository!
  var anyCancallable: Set<AnyCancellable> = []

  @Published var clinics: [ClincViewModel] = [ClincViewModel(id: 90,
                                                              name: "",
                                                              image: "d",
                                                              imageColor: "",
                                                              fontColor: "")]
  @Published var doctors: [DoctorViewModel] = []

  init(_ repository: ClinicRepository) {
    self.repository = repository
}
  func showDoctors() {
    //TODO: Remove the old doctors, when new doctors are called
     repository
      .fetchDoctors(for: Clinic(id: 0, name: "", image: ""))
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: hadleCompletion) { (newDoctor) in
        self.doctors.append(DoctorViewModel(id: newDoctor.id,
                                            name: newDoctor.name,
                                            image: newDoctor.image,
                                            description: newDoctor.description,
                                            rate: newDoctor.rating,
                                            location: newDoctor.location))
    }
  .store(in: &anyCancallable)
  }

  func showClincs() {
    repository
      .fetchClincs()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: hadleCompletion) { (newClinic) in
        self.clinics.append(ClincViewModel(id: newClinic.id,
                                           name: newClinic.name,
                                           image: newClinic.image,
                                           imageColor: radomizeImageColors(),
                                           fontColor: randomizeFontColor()))
    }
    .store(in: &anyCancallable)
  }
}

extension DoctorListViewModel {
  struct ClincViewModel: Identifiable {
    var id: Int
    var name: String
    var image: String
    var imageColor: String
    var fontColor: String

  }
  struct DoctorViewModel: Identifiable {
    var id: Int
    var name: String
    var image: String
    var description: String
    var rate: String
    var location: String
  }
}

func radomizeImageColors() -> String {
   ["babyBlueImage", "greenImage", "yellowImage"].randomElement() ?? ""
}

func randomizeFontColor() -> String {
   ["darkBlue", "lightGreen", "lightOrange"].randomElement() ?? "lightOrange"

}
