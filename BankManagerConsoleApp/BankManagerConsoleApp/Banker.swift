//
//  Banker.swift
//  BankManagerConsoleApp
//
//  Created by Yetti, redmango1446 on 2023/07/13.
//
import Foundation

struct Banker {
    private(set) var task: BankTask
    let semaphore: DispatchSemaphore
    
    init(task: BankTask,
         semaphoreValue: Int) {
        self.task = task
        self.semaphore = DispatchSemaphore(value: semaphoreValue)
    }

    func work(for customer: Customer, group: DispatchGroup) {
        DispatchQueue.global().async(group: group) {
            semaphore.wait()
            
            guard let queueNumber = customer.queueNumber else {
                return
            }
            
            print("\(queueNumber)번 \(task.korean)고객 업무 시작")
            Thread.sleep(forTimeInterval: task.time)
            print("\(queueNumber)번 \(task.korean)고객 업무 종료")
            semaphore.signal()
        }
    }

    func notifyWorkTime() -> Double {
        return task.time
    }
}
