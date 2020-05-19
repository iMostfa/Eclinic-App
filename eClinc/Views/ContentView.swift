//
//  ContentView.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @State private var isFiltering = false
  @State private var zzzz:[Double] = [0,1]
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack {
          ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4156862745, green: 0.4705882353, blue: 0.6156862745, alpha: 1)), Color(#colorLiteral(red: 0.3098039216, green: 0.3647058824, blue: 0.4980392157, alpha: 1))]), startPoint: .bottom, endPoint: .top)
              .edgesIgnoringSafeArea(.all)
            HStack {
              VStack(alignment: .leading) {
                ZStack {
                  Color(#colorLiteral(red: 0.4392156863, green: 0.4941176471, blue: 0.6352941176, alpha: 1))
                    .cornerRadius(25, corners: .bottomRight)


                    .edgesIgnoringSafeArea(.all)
                  HStack {
                    
                    Image("meDummy")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(height: 60)
                      .frame(width: 60)
                      .cornerRadius(30)
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                      Text("Mostfa Essam")
                      .font(.system(size: 15, weight: .semibold, design: .rounded))

                      Text("Ana gamed awy")
                      .font(.system(size: 10, weight: .semibold, design: .rounded))

                    }
                                       .foregroundColor(Color(#colorLiteral(red: 0.9294117647, green: 0.9568627451, blue: 0.9882352941, alpha: 1)))
                  }
                  .edgesIgnoringSafeArea(.all)

                }     .frame(height: geometry.size.height / 9)
                      .frame(width: geometry.size.width / 2)
                  .offset(y: self.isFiltering ? 0 : -1 *  geometry.size.height / 9)
                 Spacer()
                  .frame(height: geometry.size.height / 5)
                VStack(alignment: .leading, spacing: 15) {
                  MenuItem("Home", icon: "house", self.$isFiltering)
                    .background(Color(#colorLiteral(red: 0.4274509804, green: 0.4862745098, blue: 0.6156862745, alpha: 1)).cornerRadius(4))
                    MenuItem("My Appointments", icon: "square.stack", self.$isFiltering)
                      .opacity(0.6)
                    MenuItem("Profile", icon: "person.crop.square", self.$isFiltering)
                  .opacity(0.6)

                    MenuItem("Settings", icon: "gear", self.$isFiltering)
                  .opacity(0.6)

                }.padding(.leading, 10)

                Spacer()
              }
              Spacer()
            }

          }

        }

        DoctorsView(isFiltering: self.$isFiltering)
          .offset(x: self.isFiltering ? -30: 0)
          .scaleEffect(self.isFiltering ? 0.9: 1, anchor: .leading)
          .opacity(0.5)
          .zIndex(self.zzzz[0])



        DoctorsView(isFiltering: self.$isFiltering)
          .zIndex(self.zzzz[1])

      }
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    .environmentObject(DoctorListViewModel(LocalRepository()))
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

struct DoctorsView: View {
  @State private var showBlueRect = false
  @State private var showWord = false
  @State private var showPerson = false
  @State private var showSearch = false
  @State private var selectedClinic = 0
  @State private var counter = 0.2
  @EnvironmentObject var viewModel: DoctorListViewModel
  func getNumber() -> Double {
    counter += counter
    return counter
  }
  @Binding var isFiltering: Bool
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
          .frame(height: geometry.size.height / 2.5)
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

              VStack(spacing: 20) {
                ForEach(self.viewModel.doctors.indices, id: \.self) { index in
                  ZStack {
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
                  }
                  .padding(.top, index == 0 ? 10: 0)
                  .cornerRadius(20)
                  .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
                  .frame(width: geometry.size.width > 414 ? 360 : geometry.size.width - 30)
                  .frame(height: geometry.size.height / 8)

                }
              }.frame(width: geometry.size.width)

            }

            Spacer()
          }
          .offset(y: self.viewModel.doctors.count > 2 ? CGFloat(0): geometry.size.height + 50)

          .animation(Animation.spring().delay(0.6))
        }
      }.background(Color.white)
        .cornerRadius(self.isFiltering ? 30: 0)
        .offset(x: self.isFiltering ? 290: 0)
        .offset(y: self.isFiltering ? 50: 0)
        .shadow(color: Color.black.opacity(self.isFiltering ? 0.3: 0), radius: 20, x: 0, y: 0)
        .scaleEffect(self.isFiltering ? CGSize(width: 1, height: 0.9): CGSize(width: 1, height: 1), anchor: .trailing)
        .edgesIgnoringSafeArea(.all)
        .animation(Animation.spring())
        .onTapGesture {
          if self.isFiltering {
            withAnimation {
            self.isFiltering.toggle()
            }
          }
      }.onAppear {
        if self.viewModel.clinics.count > 0 {
        self.viewModel.clinics.removeFirst()
        }
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
}

struct MenuItem: View {
  var name: String
  var icon: String
  @Binding var isShown: Bool
  init(_ name: String, icon: String,_ isShown: Binding<Bool>) {
    self.name = name
    self.icon = icon
    self._isShown = isShown
  }

  var body: some View {
    HStack {
      Image(systemName:icon)
        .font(.system(size: 17, weight: .regular, design: .rounded))
        .foregroundColor(Color(#colorLiteral(red: 0.8901960784, green: 0.9215686275, blue: 0.9803921569, alpha: 1)))
      Text(name)
        .font(.system(size: 17, weight: .bold, design: .rounded))
        .foregroundColor(Color( #colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1) ))

    }
    .offset(x: self.isShown ? 0:-60)
    .padding(.vertical,5)
    .padding(.leading, 5)
    .padding(.trailing, 60)
  }
}
