//
//  BankTask.swift
//  BankManagerConsoleApp
//
//  Created by redmango1446 on 2023/07/18.
//

enum BankTask {
    case deposit
    case loans
    
    init?(_ classificationNumber: Int) {
        switch classificationNumber {
        case .deposit:
            self = .deposit
        case .loans:
            self = .loans
        default:
            return nil
        }
    }
    
    static func ~=(lhs: Self, rhs: Int) -> Bool {
        return lhs.classificationNumberValue == rhs
    }
    
    var time: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loans:
            return 1.1
        }
    }
    
    var korean: String {
        switch self {
        case .deposit:
            return "예금"
        case .loans:
            return "대출"
        }
    }
    
    private var classificationNumberValue: Int {
        switch self {
        case .deposit:
            return 1
        case .loans:
            return 2
        }
    }
}
