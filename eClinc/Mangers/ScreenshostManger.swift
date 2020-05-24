//
//  ScreenshostManger.swift
//  eClinc
//
//  Created by mostfa on 5/20/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import UIKit
/// This screenshot manger was added to take a screenshot for any View was presented on the screen
/*
 The reason of this behaviur is linked to the way the menu is implemnted in the app check (MenuView),
 the views on the menu is placed on zStack which animated and appears when the user taps on menu button,
 which means that it's loaded in the memoery, but the user don't see it, and it consumes memoery as well,
 even more it could make network request..etc, so the other way i did it, is tacking  a screenshot from
 any view that appear on the screen *by calling  toStore() function after accessing the ScreenshotsManger
 as envrionment Object
 */
class ScreenshotsManger: ObservableObject {

  @Published var screenshotsStack: [Screenshot] = []
  private var currentCount = 1
  func toStore() {
    DispatchQueue.main.async {

    // TODO:  Check if the image of the view being caputred is already added or not
    var screenshotImage: UIImage?
      var currentVC = UIApplication.shared.windows.first!.rootViewController!
      while currentVC.presentedViewController != nil {
        currentVC =  currentVC.presentedViewController!
      }
      let lastlayer = currentVC.view.layer

    let scale = 3
    UIGraphicsBeginImageContextWithOptions(lastlayer.frame.size, false, CGFloat(scale))

    guard let context = UIGraphicsGetCurrentContext() else {return}
    lastlayer.render(in: context)
    screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    if let image = screenshotImage {
      print("Screenshot was caputred, will be added to screenshots")
      self.currentCount += 1
      self.screenshotsStack.append(.init(id: self.currentCount, image: image))
     }
  }
  }

}

extension ScreenshotsManger: Identifiable {

  struct Screenshot: Identifiable {
    var id: Int
    var image: UIImage
  }

}
