//
//  RangeExtension.swift
//  Guess Number Game
//
//  Created by Vova on 14.08.2021.
//

import Foundation

extension Range: SpecificNumericRangeProtocol where Bound: BinaryInteger, Bound.Stride: SignedInteger{
}
