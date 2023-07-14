//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

struct BankManager {
    func selectMenu() {
        var isBankOpen: Bool = true
        
        while isBankOpen {
            print("1 : 은행개점")
            print("2 : 종료")
            print("입력 :", terminator: " ")
            let selection = readLine()
            
            switch selection {
            case "1":
                openBank()
            case "2":
                isBankOpen = false
            default:
                print("잘못된 입력입니다.")
            }
        }
    }
    
    private func openBank() {
        let bankers = createBankers(number: 1)
        var customers = createCustomers()
        var bank: Bank = Bank(bankers: bankers)
        
        bank.startBankService(&customers)
    }
    
    private func createBankers(number: Int) -> [Banker] {
        return Array(repeating: Banker(), count: number)
    }
    
    private func createCustomers() -> [Customer] {
        let customerNumbers: Int = Int.random(in: 10...30)
        
        return Array(repeating: Customer(), count: customerNumbers)
    }
}
