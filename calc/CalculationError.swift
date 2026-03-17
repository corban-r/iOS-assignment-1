//
//  CalculationError.swift
//  calc
//
//  Defines error types for the calculator.
//

import Foundation

enum CalculationError: Error {
    case invalidInput(String)
    case divisionByZero
    case overflowError
}
