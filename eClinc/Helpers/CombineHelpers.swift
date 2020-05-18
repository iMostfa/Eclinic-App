//
//  CombineHelpers.swift
//  eClinc
//
//  Created by mostfa on 5/17/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine

/*
 This function is used as first class parameter for the function MapError in combine,
 to map any Never error to EClincError.Never, because when using Combine, all type of erros need to be same type
/// - Parameter error: Never, if not will return bad errorConversion
 */
func mapNever(_ error: Error) -> EClincError {
  guard error is Never else {return EClincError.badErrorConversion}
  return EClincError.never
}

/// This function prints the completion for Any sink value
/// - Parameter completion: the completion passed to it
func hadleCompletion(_ completion: Subscribers.Completion<EClincError>) {
  print(completion)
}
