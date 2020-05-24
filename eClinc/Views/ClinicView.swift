//
//  ClinicView.swift
//  eClinc
//
//  Created by mostfa on 5/24/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI

struct ClinicView: View {
  @Binding var selectedClinic: Int
  var clinic: DoctorListViewModel.ClincViewModel
  var geometry: GeometryProxy
  var onTapGesture: () -> Void
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(self.selectedClinic == clinic.id ? Color.blue: Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)))
        .cornerRadius(12)
        .padding(.leading, 2.5)
        .padding(.trailing, 2.5)

      VStack {

        HStack {

          ZStack {
            Rectangle()
              .foregroundColor(self.selectedClinic == clinic.id ?
                Color.white:
                Color(clinic.fontColor).opacity(0.4))
              .cornerRadius(7)
              .frame(width: 35, height: 35)
            Image("nose")
              .resizable()
              .renderingMode(.template)
              .aspectRatio(contentMode: .fill)
              .foregroundColor(Color(clinic.fontColor))
              .frame(width: 35, height: 35)
          }
          Spacer()
        }.padding(.top, 5)
          .padding(.horizontal, 10)

        Spacer()

        Text(clinic.name)
          .font(.system(size: 20, weight: .semibold, design: .rounded))
          .foregroundColor(self.selectedClinic == clinic.id ?
            Color.white: Color(clinic.fontColor))
          .padding(.bottom, 5)
      }

    }
    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    .onTapGesture {
      withAnimation {
        self.selectedClinic = self.clinic.id
        self.onTapGesture()
      }
    }
    .frame(width: geometry.size.width / 3, height: geometry.size.height / 6)

  }
}

struct ClinicView_Previews: PreviewProvider {
  static var previews: some View {
  let clinic = DoctorListViewModel.ClincViewModel(id: 0,
                                                  name: "health Problems",
                                                  image: "",
                                                  imageColor: "",
                                                  fontColor: "")
    return GeometryReader { geometry in
      ClinicView(selectedClinic: .constant(0), clinic: clinic, geometry: geometry) {

      }
    }

  }
}
