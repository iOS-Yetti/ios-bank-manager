//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

struct BankManager {
    func selectMenu() {
        var isBankOpened: Bool = true
        
        while isBankOpened {
            print("1 : 은행개점")
            print("2 : 종료")
            print("입력 :", terminator: " ")
            let selection = readLine()
            
            switch selection {
            case numberOption.openBank:
                openBank()
            case numberOption.exit:
                isBankOpened = false
            default:
                print("잘못된 입력입니다.")
            }
        }
    }
    
    private func openBank() {
        guard var customers = try? createCustomers() else {
            return
        }
        var bank = Bank(depositBankers: Banker(task: .deposit, semaphoreValue: 2),
                        loanBankers: Banker(task: .loan, semaphoreValue: 1))
        
        bank.startBankService(&customers)
    }
    private func createCustomers() throws -> [Customer] {
        let customerNumbers = Int.random(in: 10...30)
        var customers = [Customer]()
        
        for _ in 1...customerNumbers {
            guard let task = BankTask.allCases.randomElement() else {
                throw BankSystemError.noTask
            }
            
            customers.append(Customer(task: task))
        }
        
        return customers
    }
}

extension BankManager {
    enum numberOption {
        static let openBank = "1"
        static let exit = "2"
    }
}
