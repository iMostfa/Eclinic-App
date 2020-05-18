//
//  ContentView.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var showBlueRect = false
  @State private var showWord = false
  @State private var showPerson = false
  @State private var showSearch = false
  @State private var selectedClinic = 0
  @State private var counter = 0.2
  @State private var isFiltering = false
  @ObservedObject var viewModel = DoctorListViewModel(LocalRepository())
  func getNumber() -> Double {
    counter += counter
    return counter
  }
  var body: some View {
    GeometryReader { geometry in
      VStack {
        VStack(spacing: 0) {
          ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.8392156863, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.3803921569, blue: 0.7019607843, alpha: 1))]), startPoint: .top, endPoint: .bottom)
              .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))
              .opacity(self.showBlueRect ? 1 : 0)
              .offset(y: self.showBlueRect ? 0 :  -1 * (geometry.size.height / 3))
              .animation(Animation.easeInOut.delay(0.1))
            VStack(spacing: 0) {
              HStack {
                Text("Best Doctors \n avaliable to you ")
                  .font(.system(size: 30, weight: .semibold, design: .rounded))
                  .foregroundColor(Color.white)
                  .offset(y: -10)
                  .opacity(self.showWord ? 1 : 0)
                  .offset(x: self.showWord ? 0 : -90)
                  .animation(Animation.spring().delay(0.4))
                Image("doctor")
                  .resizable()
                  .frame(height: 150)
                  .frame(width: 90)
                  .opacity(self.showPerson ? 1 : 0)
                  .offset(x: self.showPerson ? 0 : 90)
                  .animation(Animation.spring().delay(0.2))
              }
              ZStack {
                Color.white
                  .cornerRadius(20)
                HStack {
                  TextField("Write doctor name or your problem", text: .constant(""))
                    .padding(.vertical, 10)
                  Image(systemName: "magnifyingglass")
                }
                .padding(.horizontal, 10)
              } .frame(width: geometry.size.width > 414 ? 360 : geometry.size.width - 40)
                .frame(height: 40)
                .opacity(self.showSearch ? 1 : 0)
                .offset(y: self.showSearch ? 0 : 90)
                .animation(Animation.spring().delay(0.3))
            }
          }
          .edgesIgnoringSafeArea(.top)
          .frame(height: geometry.size.height / 3)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(self.viewModel.clinics) { clinic in
                HStack {
                  ClinicView(selectedClinic: self.$selectedClinic, clinic: clinic, geometry: geometry) {
                    self.viewModel.doctors.removeAll()
                    self.viewModel.showDoctors()
                  }
                 }

              }
            }.padding(.bottom, 19)
          }
          .padding(.bottom, -25)
          .offset(y: -1 * 40)
          .offset(x: self.viewModel.clinics.count > 2 ? 0: 500)
            .animation(Animation.easeOut(duration: 0.3).delay(Double(0.1)))

          VStack(spacing: 20) {
            HStack {
              Text("\(self.viewModel.doctors.count)"+" Doctor is Available for you")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("SecondaryText"))
              Spacer()
              Button(action: {
                withAnimation {
                self.isFiltering.toggle()
                }
              }) {
                HStack {
                  VStack(alignment: self.isFiltering ? .leading: .trailing, spacing: 1) {
                    Rectangle()
                      .frame(width: 20, height: 2.5)
                    .cornerRadius(1)
                    Rectangle()
                      .frame(width: 15, height: 2.5)
                    .cornerRadius(1)
                    Rectangle()
                      .frame(width: 9, height: 2.5)
                    .cornerRadius(1)
                  }
                Text("Filter")
                  .font(.system(size: 17, weight: .semibold, design: .rounded))
                }
                .foregroundColor(Color.blue)
              }
              .buttonStyle(PlainButtonStyle()) //to disable the white overlay when tapped

            }.padding(.horizontal, 10)
            ScrollView(.vertical, showsIndicators: true) {

            VStack(spacing: 15) {
              ForEach(self.viewModel.doctors.indices, id: \.self) { index in
                return ZStack {
                    Color.white
                    VStack {
                      HStack {
                        Image("")
                          .frame(width: 50, height: 50)
                          .background(Color.green.cornerRadius(15))
                          .padding(.leading, 3)
                        VStack(alignment: .leading, spacing: 2) {
                          Text(self.viewModel.doctors[index].name)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("mainText"))
                          Text(self.viewModel.doctors[index].description)
                            .padding(.leading, 4)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                          .foregroundColor(Color("SecondaryText"))
                          .frame(width: geometry.size.width > 414 ? 360 : geometry.size.width - 120)


                        }
                      }.padding(.horizontal, 3)
                      HStack {
                        HStack(spacing: 4) {
                          Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color("pinColor"))
                          Text(self.viewModel.doctors[index].location)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                          .foregroundColor(Color("SecondaryText"))
                        }
                        Spacer()
                          .frame(width: geometry.size.width / 3)
                        HStack(spacing: 4) {
                          Image(systemName: "star.fill")
                            .foregroundColor(Color("pinColor"))
                          Text(self.viewModel.doctors[index].rate)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                          .foregroundColor(Color("SecondaryText"))
                        }
                      }

                    }
                    }.cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                    .frame(width: geometry.size.width > 414 ? 360 : geometry.size.width - 30)
                    .frame(height: geometry.size.height / 8)

                }
            }
            }

Spacer()
          }.offset(y: self.viewModel.doctors.count > 2 ? CGFloat(0): geometry.size.height + 50)
          .animation(Animation.spring().delay(0.6))
        }
      }.edgesIgnoringSafeArea(.bottom)
    }
    .onAppear {
      self.viewModel.clinics.removeFirst()
       self.showBlueRect.toggle()
       self.showPerson.toggle()
      self.showWord.toggle()
      self.showSearch.toggle()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.viewModel.showClincs()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.viewModel.showDoctors()
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct ClinicView: View {
  @Binding var selectedClinic: Int
  var clinic: DoctorListViewModel.ClincViewModel
  var geometry: GeometryProxy
  var onTapGesture: () -> Void
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(self.selectedClinic == clinic.id ? Color.blue : Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)) )
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
