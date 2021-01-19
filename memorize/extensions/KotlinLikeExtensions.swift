//
//  KotlinLikeExtensions.swift
//  memorize
//
//  Created by Artem Japparov on 17.01.2021.
//

import Foundation
import UIKit

infix operator <-< : AssignmentPrecedence
func <-<<T:AnyObject>(left:T, right:(T)->()) -> T
{
  right(left)
  return left
}
