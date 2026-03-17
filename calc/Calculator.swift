//
//  Calculator.swift
//  calc
//
//  Evaluates arithmetic expressions with correct operator precedence.
//

import Foundation

class Calculator {

    /// Evaluates a sequence of command-line arguments as an arithmetic expression.
    func calculate(args: [String]) throws -> Int {
        let expression = try Expression(args: args)
        return try evaluate(numbers: expression.numbers, operators: expression.operators)
    }

    /// Evaluates the expression using two-pass precedence:
    /// 1. Evaluate x, /, % (left to right)
    /// 2. Evaluate +, - (left to right)
    private func evaluate(numbers: [Int], operators: [String]) throws -> Int {
        var nums = numbers
        var ops = operators

        // First pass: high-precedence operators (x, /, %)
        var i = 0
        while i < ops.count {
            if ops[i] == "x" || ops[i] == "/" || ops[i] == "%" {
                let result = try performOperation(lhs: nums[i], op: ops[i], rhs: nums[i + 1])
                nums[i] = result
                nums.remove(at: i + 1)
                ops.remove(at: i)
            } else {
                i += 1
            }
        }

        // Second pass: low-precedence operators (+, -)
        var result = nums[0]
        for i in 0..<ops.count {
            result = try performOperation(lhs: result, op: ops[i], rhs: nums[i + 1])
        }

        return result
    }

    /// Performs a single arithmetic operation with overflow and division-by-zero checking.
    private func performOperation(lhs: Int, op: String, rhs: Int) throws -> Int {
        switch op {
        case "+":
            let (result, overflow) = lhs.addingReportingOverflow(rhs)
            if overflow { throw CalculationError.overflowError }
            return result
        case "-":
            let (result, overflow) = lhs.subtractingReportingOverflow(rhs)
            if overflow { throw CalculationError.overflowError }
            return result
        case "x":
            let (result, overflow) = lhs.multipliedReportingOverflow(by: rhs)
            if overflow { throw CalculationError.overflowError }
            return result
        case "/":
            if rhs == 0 { throw CalculationError.divisionByZero }
            let (result, overflow) = lhs.dividedReportingOverflow(by: rhs)
            if overflow { throw CalculationError.overflowError }
            return result
        case "%":
            if rhs == 0 { throw CalculationError.divisionByZero }
            let (result, overflow) = lhs.remainderReportingOverflow(dividingBy: rhs)
            if overflow { throw CalculationError.overflowError }
            return result
        default:
            throw CalculationError.invalidInput("Unknown operator: \(op)")
        }
    }
}
