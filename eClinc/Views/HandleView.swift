//
//  HandleView.swift
//  eClinc
//
//  Created by mostfa on 5/20/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import SwiftUI

struct Handle: View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}
