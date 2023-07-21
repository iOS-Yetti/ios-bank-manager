//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Yetti, redmango1446 on 2023/07/13.
//
import Foundation

class Bank {
    private let bankers: [Banker]
    private let group = DispatchGroup()
    private var depositQueue: CustomerQueue<Customer> = CustomerQueue()
    private var loanQueue: CustomerQueue<Customer> = CustomerQueue()
    private var finishedCustomerCount: Int = .zero
    private var totalWorkTime: Double = .zero
    
    init(bankers: [Banker]) {
        self.bankers = bankers
    }
    
    private func lineUp(_ customers: inout [Customer]) {
        for number in 0..<customers.count {
            customers[number].receiveQueueNumber(queueNumber: number + 1)
            
            switch customers[number].task {
            case .deposit:
                depositQueue.enqueue(customers[number])
            case .loan:
                loanQueue.enqueue(customers[number])
            }
        }
    }
    
    func startBankService(_ customers: inout [Customer]) {
        lineUp(&customers)
        
        for i in 0..<bankers.count {
            var queue: CustomerQueue<Customer>
            
            switch bankers[i].task {
            case .deposit:
                queue = depositQueue
            case .loan:
                queue = loanQueue
            }
            
            DispatchQueue.global().async(group: group) { [self] in
                while let customer = queue.dequeue() {
                    bankers[i].work(for: customer)
                    countFinishedCustomer()
                    checkWorkTime(from: bankers[i])
                }
            }
        }
        
        group.wait()
        workFinish()
    }
    
    private func countFinishedCustomer() {
        finishedCustomerCount += 1
    }
    
    private func checkWorkTime(from banker: Banker) {
        totalWorkTime += banker.notifyWorkTime()
    }
    
    private func workFinish() {
        let totalWorkTime = String(format: "%.2f", totalWorkTime)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(finishedCustomerCount)명이며, 총 업무시간은 \(totalWorkTime)초입니다.")
    }
}