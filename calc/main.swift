//
//  main.swift
//  calc
//
//  Entry point for the command-line calculator.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the program name

let calculator = Calculator()

do {
    let result = try calculator.calculate(args: args)
    print(result)
} catch CalculationError.invalidInput(let message) {
    fputs("Error: \(message)\n", stderr)
    exit(1)
} catch CalculationError.divisionByZero {
    fputs("Error: Division by zero\n", stderr)
    exit(1)
} catch CalculationError.overflowError {
    fputs("Error: Integer overflow\n", stderr)
    exit(1)
} catch {
    fputs("Error: \(error)\n", stderr)
    exit(1)
}
