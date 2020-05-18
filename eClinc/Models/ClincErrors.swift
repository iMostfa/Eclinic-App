//
//  ClincErrors.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine
/// Default erros type in the App
/// Never is used when mapping the error Never form a publisher that will Never publish an error
enum EClincError: Error {
  case never
  case urlSession
  case badErrorConversion //when trying to convert from Never error, while the error isNot Never
}
