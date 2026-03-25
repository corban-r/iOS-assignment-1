import Foundation

class Expression {
    private(set) var numbers: [Int]
    private(set) var operators: [String]

    static let validOperators = ["+", "-", "x", "/", "%"]

    init(args: [String]) throws {
        guard args.count > 0, args.count % 2 == 1 else {
            throw CalculationError.invalidInput("Invalid expression")
        }

        numbers = []
        operators = []

        for i in 0..<args.count {
            if i % 2 == 0 {
                guard let num = Int(args[i]) else {
                    throw CalculationError.invalidInput("Invalid number: \(args[i])")
                }
                numbers.append(num)
            } else {
                let op = args[i]
                guard Expression.validOperators.contains(op) else {
                    throw CalculationError.invalidInput("Invalid operator: \(op)")
                }
                operators.append(op)
            }
        }
    }
}
