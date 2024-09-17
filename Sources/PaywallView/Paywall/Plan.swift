//
//  Plan.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation

public struct Plan: Equatable, Hashable {
    public var id: String
    public var name: String
    public var cost: String
    public var primaryInfo: String
    public var secondaryIndo: String
    public var primary: Bool
    public var badge: Badge?
    public var actionButtonPrimaryTitle: String?

    public init(
        id: String,
        name: String,
        cost: String,
        primaryInfo: String,
        secondaryIndo: String,
        primary: Bool,
        badge: Badge? = nil,
        actionButtonPrimaryTitle: String? = nil
    ) {
        self.id = id
        self.name = name
        self.cost = cost
        self.primaryInfo = primaryInfo
        self.secondaryIndo = secondaryIndo
        self.primary = primary
        self.badge = badge
        self.actionButtonPrimaryTitle = actionButtonPrimaryTitle
    }
}

extension Plan {
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
