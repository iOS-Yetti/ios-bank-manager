//
//  Banker.swift
//  BankManagerConsoleApp
//
//  Created by Yetti, redmango1446 on 2023/07/13.
//
import Foundation

protocol Bankerable {
    var work: BankerWork { get }
    
    mutating func work(for customer: Customer)
    func notifyWorkTime() -> Double
}

enum BankerWork {
    case deposit
    case loans
    
    var time: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loans:
            return 1.1
        }
    }
}

struct Banker: Bankerable {
    var work: BankerWork
    
    init(work: BankerWork) {
        self.work = work
    }
    
    func work(for customer: Customer) {
        guard let queueNumber = customer.queueNumber else {
            return
        }
        
        print("\(queueNumber)번 고객 업무 시작")
        Thread.sleep(forTimeInterval: work.time)
        print("\(queueNumber)번 고객 업무 종료")
    }
    
    func notifyWorkTime() -> Double {
        return work.time
    }
}
