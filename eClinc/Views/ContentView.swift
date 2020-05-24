//
//  MenuView.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI

struct MenuView: View {

  @State private var isMenu = false
  @State var showGreen = false
  @State var showRed = true
  @EnvironmentObject var screenshotsManger: ScreenshotsManger
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
                  .offset(y: self.isMenu ? 0 : -1 *  geometry.size.height / 9)
                 Spacer()
                  .frame(height: geometry.size.height / 5)
                // MARK: - side menu items

                VStack(alignment: .leading, spacing: 15) {
                  MenuItem("Home", icon: "house", self.$isMenu)
                    .background(Color(#colorLiteral(red: 0.4274509804, green: 0.4862745098, blue: 0.6156862745, alpha: 1)).cornerRadius(4))
                    MenuItem("My Appointments", icon: "square.stack", self.$isMenu)
                      .opacity(0.6)
                    MenuItem("Profile", icon: "person.crop.square", self.$isMenu)
                  .opacity(0.6)

                    MenuItem("Settings", icon: "gear", self.$isMenu)
                  .opacity(0.6)

                }.padding(.leading, 10)

                Spacer()
              }
              Spacer()
            }

          }

        }

        // MARK: - stack of views
        ForEach(self.screenshotsManger.screenshotsStack.reversed()) { screenshot in
            Image(uiImage: screenshot.image)
            .cornerRadius(25)
              .offset(x: self.isMenu ? CGFloat(295 +  CGFloat(screenshot.id * -30)): 0)
              .shadow(color: Color.black.opacity(self.isMenu ? 0.3: 0), radius: 20, x: 0, y: 0)
              .scaleEffect(self.isMenu ? screenshot.id == 2 ? CGSize(width: 1,
                height: 0.80 ): CGSize(width: 1,
                height: 0.67 ) :
                CGSize(width: 1, height: 1), anchor: .bottomTrailing)
              .opacity(0.8)
              .padding(.bottom, screenshot.id == 2 ? 70: 150)
              .frame(width: geometry.size.width, height: geometry.size.height)

          }
        DoctorsListView(isMenu: self.$isMenu)

        // MARK: - END of the stack of views

      }
    }.sheet(isPresented: self.$showRed) {
      Color.red
        .edgesIgnoringSafeArea(.all)
        .onAppear {
          self.screenshotsManger.toStore()
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showGreen.toggle()
          }

      }
      .sheet(isPresented: self.$showGreen) {
        Color.blue
          .edgesIgnoringSafeArea(.all)

          .onAppear {
            self.screenshotsManger.toStore()
        }
      }
    }

  }
}

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    let doctor = Doctor(id: 0,
                        name: "Mostfa Essam",
                        image: "meDummy",
                        description: "Ana GAMEEEEEEEEEEEEEDAwwwy",
                        location: "Gamed",
                        rating: "5",
                        daysAvilable: ["May", "Mon"])
    return MenuView()
      .environmentObject(DoctorListViewModel(LocalRepository()))
      .environmentObject(AppointmentViewModel(doctor: doctor, LocalRepository()))
      .environmentObject(ScreenshotsManger())  }
}

struct MenuItem: View {
  var name: String
  var icon: String
  @Binding var isShown: Bool
  init(_ name: String, icon: String, _ isShown: Binding<Bool>) {
    self.name = name
    self.icon = icon
    self._isShown = isShown
  }

  var body: some View {
    HStack {
      Image(systemName: icon)
        .font(.system(size: 17, weight: .regular, design: .rounded))
        .foregroundColor(Color(#colorLiteral(red: 0.8901960784, green: 0.9215686275, blue: 0.9803921569, alpha: 1)))
      Text(name)
        .font(.system(size: 17, weight: .bold, design: .rounded))
        .foregroundColor(Color( #colorLiteral(red: 0.9529411765, green: 0.968627451, blue: 1, alpha: 1) ))

    }
    .offset(x: self.isShown ? 0:-60)
    .padding(.vertical, 5)
    .padding(.leading, 5)
    .padding(.trailing, 60)
  }
}
