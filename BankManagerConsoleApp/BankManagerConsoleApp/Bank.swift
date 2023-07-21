//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Yetti, redmango1446 on 2023/07/13.
//
import Foundation

struct Bank {
    private let depositBankers: Banker
    private let loanBankers: Banker
    private var bankQueue: CustomerQueue<Customer> = CustomerQueue()
    private var finishedCustomerCount: Int = .zero
    private var totalWorkTime: Double = .zero
    private let dispatchGroup = DispatchGroup()
    
    init(depositBankers: Banker, loanBankers: Banker) {
        self.depositBankers = depositBankers
        self.loanBankers = loanBankers
    }
    
    mutating private func lineUp(_ customers: inout [Customer]) {
        for number in 0..<customers.count {
            customers[number].receiveQueueNumber(queueNumber: number + 1)
            bankQueue.enqueue(customers[number])
        }
    }
    
    mutating func startBankService(_ customers: inout [Customer]) {
        lineUp(&customers)
        
        while let currentCustomer = bankQueue.dequeue() {
            switch currentCustomer.task {
            case .deposit:
                depositBankers.work(for: currentCustomer,
                                    group: dispatchGroup)
            case .loan:
                loanBankers.work(for: currentCustomer,
                                 group: dispatchGroup)
            }
            
        }
        dispatchGroup.wait()
        workFinish()
    }
//      고객 수 및 총 업무시간 미 구현
//    mutating private func countFinishedCustomer() {
//        finishedCustomerCount += 1
//    }
//
//    mutating private func checkWorkTime(from banker: Banker) {
//        totalWorkTime += banker.notifyWorkTime()
//    }
    
    private func workFinish() {
        let totalWorkTime = String(format: "%.2f", totalWorkTime)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(finishedCustomerCount)명이며, 총 업무시간은 \(totalWorkTime)초입니다.")
    }
}
