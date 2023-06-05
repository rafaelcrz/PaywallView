//
//  Plan.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation

struct Plan: Hashable {
    var id: String
    var name: String
    var cost: String
    var primaryInfo: String
    var secondaryIndo: String
    var primary: Bool
    var badge: Badge?
    var actionButtonPrimaryTitle: String?
    
    static var previewMonthly: Plan {
        return Plan(
            id: "monthly",
            name: "Monthly",
            cost: "R$ 4.99",
            primaryInfo: "7 days free trial",
            secondaryIndo: "($4.17/mo)",
            primary: true,
            badge: .preview()
        )
    }
    
    static var previewYearly: Plan {
        return Plan(
            id: "yearly",
            name: "Yearly",
            cost: "R$ 214.99",
            primaryInfo: "7 days free trial",
            secondaryIndo: "($4.17/mo)",
            primary: true,
            badge: .preview(alwaysVisible: false),
            actionButtonPrimaryTitle: "Action plan title"
        )
    }
}
