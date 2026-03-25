import Foundation

enum CalculationError: Error {
    case invalidInput(String)
    case divisionByZero
    case overflowError
}
