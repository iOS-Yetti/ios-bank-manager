//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by Yetti, redmango1446 on 2023/07/13.
//

protocol Customerable {
    var queueNumber: Int? { get }
    
    mutating func receiveQueueNumber(queueNumber: Int)
}

struct Customer: Customerable, BankTaskable {
    private(set) var queueNumber: Int?
    private(set) var task: BankTask
    
    init(queueNumber: Int? = nil, task: BankTask) {
        self.queueNumber = queueNumber
        self.task = task
    }
    
    mutating func receiveQueueNumber(queueNumber: Int) {
        self.queueNumber = queueNumber
    }
}
