//
//  AppointmentView.swift
//  eClinc
//
//  Created by mostfa on 5/20/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI

struct AppointmentView: View {
  @EnvironmentObject var viewModel: AppointmentViewModel
  @State var selectedDay = "15"
  @State var selectedTime = "00:00"
  @State var selectedCard = ""
  @Binding var position: CardPosition
  var geometry: GeometryProxy
  var body: some View {
    // MARK: - Doctor View

    VStack {
      HStack {
        HStack(alignment: .top) {
          Image(self.viewModel.doctor.image)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 90)
            .frame(height: 90)
          VStack(alignment: .leading) {
            Text(self.viewModel.doctor.name)
              .font(.system(size: 17, weight: .semibold, design: .rounded))
              .foregroundColor(Color("mainText"))

            Text(self.viewModel.doctor.description)
              .font(.system(size: 12, weight: .medium, design: .rounded))
              .foregroundColor(Color("SecondaryText"))

          }
        }
        .padding(.top, 20)

        Spacer()
      }

      .padding(5)

      // MARK: - Avaliable Days View

      VStack {

        HStack {
          Text("Avaliable Days")
            .font(.system(size: 18, weight: .bold, design: .rounded))
          Spacer()
        }
        .padding(.horizontal, 10)

      }

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(self.viewModel.availableDays.indices, id: \.self) { index in
            AvaliableDayView(geometry: self.geometry,
                             month: self.viewModel.availableDays[index].month,
                             number: self.viewModel.availableDays[index].number,
                             id: self.viewModel.availableDays[index].number,
                             selectedId: self.$selectedDay) {
                              self.viewModel.fetchSlots(for: self.viewModel.availableDays[index])
                              withAnimation {

                                self.position = .avaliableSlots
                              }
            }
          }
        }
        .frame(
          height: geometry.size.height / 8)
          .padding(.vertical, 5)

      }
        //          .opacity(self.position == .middle ? 1: 0)
        //          .offset(y:self.position == .middle ? 0 : 1000)
        .frame(width: geometry.size.width)
      // MARK: - Avaliable slots
      VStack {
        HStack {
          Text("Avaliable Sessions")
            .font(.system(size: 18, weight: .bold, design: .rounded))
          Spacer()
        }
        .padding(.horizontal, 10)

        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(self.viewModel.availableSlots.indices, id: \.self) { index in
              AvaliableSlotView(geometry: self.geometry,
                                time: self.viewModel.availableSlots[index].time,
                                id: self.viewModel.availableSlots[index].time,
                                selectedId: self.$selectedTime) {
                                  self.position = .avaliableCards
              }
            }

          }.padding(.leading, 1)
            .frame(
              height: geometry.size.height / 25)
            .padding(.vertical, 5)

        }
        .frame(width: geometry.size.width)

      }.padding(.top, self.position == .middle ? 50: 0)

      // MARK: - Card Info
      VStack {
        HStack {
          Text("Checkout")
            .font(.system(size: 18, weight: .bold, design: .rounded))
          Spacer()
        }
        .padding(.horizontal, 10)
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(self.viewModel.avaliableCards, id: \.self) { index in
              AvaliableCard(geometry: self.geometry, time: index, id: index, selectedId: self.$selectedCard) {
                self.selectedCard = index
                self.position = .confirmButton
              }
            }

          }.padding(.leading, 1)
            .frame(
              height: geometry.size.height / 25)
            .padding(.vertical, 5)

        }
      }
      //        .opacity(self.position == .avaliableCards ? 1: 0)
      //        .offset(y:self.position == .avaliableCards ? 0 : 1000)
      // MARK: - Card Info

      Button(action: {

      }) {
        ZStack {
          Color.blue
            .frame(width: geometry.size.width / 2)
            .frame(height: geometry.size.height / 13)
            .cornerRadius(geometry.size.height / 13 / 2)

          Text("Confirm booking!")
            .foregroundColor(Color.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))

        }
        .padding(.top, 20)
        //          .opacity(self.position == .confirmButton ? 1: 0)
        //          .offset(y:self.position == .confirmButton ? 0 : 1000)

      }
      Spacer()
    }
    .onAppear {
      self.viewModel.fetchDays()

    }
  }
}

struct AppointmentView_Previews: PreviewProvider {
  static var previews: some View {
    let doctor = Doctor(id: 0,
                        name: "Mostfa Essam",
                        image: "meDummy",
                        description: "Ana GAMEEEEEEEEEEEEEDAwwwy",
                        location: "Gamed",
                        rating: "5",
                        daysAvilable: ["May", "Mon"])
    let model = AppointmentViewModel(doctor: doctor, LocalRepository())
    return GeometryReader { geometry in
      AppointmentView(position: .constant(.middle), geometry: geometry)
        .environmentObject(model)
        .onAppear {
          model.fetchSlots(for: AvailableDay(id: 0, number: "", month: "  "))
      }
    }
  }
}

struct AvaliableDayView: View {
  var geometry: GeometryProxy
  var month: String
  var number: String
  var id: String

  @Binding var  selectedId: String

  var onTapGesture: () -> Void

  var body: some View {
    Button(action: {
      withAnimation(Animation.spring()) {
        self.selectedId = self.id
        self.onTapGesture()
      }
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(self.id ==  selectedId ? Color(#colorLiteral(red: 0.1882352941, green: 0.4431372549, blue: 0.7215686275, alpha: 1)): Color(#colorLiteral(red: 0.7176470588, green: 0.8274509804, blue: 0.9333333333, alpha: 1)),
                      lineWidth: Int(self.id) ?? 0 == Int(selectedId) ?? -1 ? 3: 2)
        )
          .foregroundColor(Int(self.id) ?? 0 == Int(selectedId) ?? -1 ? Color(#colorLiteral(red: 0.5568627451, green: 0.7921568627, blue: 1, alpha: 1)): Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
          .frame(width: geometry.size.width / 5,
                 //FIXME: Pass the geometry of parrent, don't use this geometry
            height: geometry.size.height / 8)
        VStack {
          Text(number)
            .font(.system(size: 40, weight: .medium, design: .rounded))
          Text(month)
            .font(.system(size: 20, weight: .medium, design: .rounded))
        }

      }
      .frame(width: geometry.size.width / 5,
             height: geometry.size.height / 8)

    }
  }
}

struct AvaliableSlotView: View {
  var geometry: GeometryProxy
  var time: String
  var id: String

  @Binding var  selectedId: String

  var onTapGesture: (() -> Void)?

  var body: some View {
    Button(action: {
      withAnimation(Animation.spring()) {
        self.selectedId = self.id
        self.onTapGesture?()
      }
    }) {
      ZStack {


        RoundedRectangle(cornerRadius: 4)
          .overlay(
            RoundedRectangle(cornerRadius: 4)
              .stroke(self.id ==  selectedId ? Color(#colorLiteral(red: 0.1882352941, green: 0.4431372549, blue: 0.7215686275, alpha: 1)): Color(#colorLiteral(red: 0.7176470588, green: 0.8274509804, blue: 0.9333333333, alpha: 1)),
                      lineWidth: Int(self.id) ?? 0 == Int(selectedId) ?? -1 ? 3: 2)
        )
          .foregroundColor(self.id ==  selectedId ? Color(#colorLiteral(red: 0.5568627451, green: 0.7921568627, blue: 1, alpha: 1)): Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 0)))
          .frame(width: geometry.size.width / 4,
                 height: geometry.size.height / 25)

      VStack {
              Text(time)
                .font(.system(size: 20, weight: .medium, design: .rounded))
              //  .foregroundColor(Color.black)
            }
      }

    }
    .frame(width: geometry.size.width / 4,
           height: geometry.size.height / 25)

  }
}

struct AvaliableCard: View {
  var geometry: GeometryProxy
  var time: String
  var id: String

  @Binding var  selectedId: String

  var onTapGesture: (() -> Void)?

  var body: some View {
    Button(action: {
      self.selectedId = self.id
      self.onTapGesture?()
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .overlay(
            RoundedRectangle(cornerRadius: 4)
              .stroke(self.id ==  selectedId ? Color(#colorLiteral(red: 0.1882352941, green: 0.4431372549, blue: 0.7215686275, alpha: 1)): Color(#colorLiteral(red: 0.7176470588, green: 0.8274509804, blue: 0.9333333333, alpha: 1)),
                      lineWidth: Int(self.id) ?? 0 == Int(selectedId) ?? -1 ? 3: 2)
        )
          .foregroundColor(self.id ==  selectedId ? Color(#colorLiteral(red: 0.5568627451, green: 0.7921568627, blue: 1, alpha: 1)): Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
          .frame(width: self.id ==  selectedId ? geometry.size.width / 3 :  geometry.size.width / 4,
                 height: geometry.size.height / 25)
        HStack {
          Text(time)
            .font(.system(size: 20, weight: .medium, design: .rounded))
          if  self.id ==  selectedId {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(Color.white)
          }
        }

      }
      .frame(width: self.id ==  selectedId ? geometry.size.width / 3 :  geometry.size.width / 4,
             height: geometry.size.height / 25)

    }
  }
}
