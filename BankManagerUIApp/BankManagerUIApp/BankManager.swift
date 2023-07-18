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
        let bankers = createBankers()
        var customers = createCustomers()
        var bank = Bank(bankers: bankers)
        
        bank.startBankService(&customers)
    }
    
    private func createRandomCustomerTask() -> BankTask {
        let taskNumber = Int.random(in: 1...2)

        guard let task = BankTask(taskNumber) else {
            return BankTask.deposit //추후 에러처리
        }
        
        return task
    }
    
    private func createBankers() -> [Bankerable] {
        let bankers = [Banker(task: .deposit),
                       Banker(task: .deposit),
                       Banker(task: .loans)]
        
        return bankers
    }
    
    private func createCustomers() -> [Customerable] {
        let customerNumbers = Int.random(in: 10...30)
        var customers = [Customer]()
        
        for _ in 0...customerNumbers {
            let customerTask = createRandomCustomerTask()
            customers.append(Customer(task: customerTask))
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
