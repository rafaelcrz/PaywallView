//
//  PlanOptionListView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation

import SwiftUI

struct Plan: Hashable {
    var id: String
    var name: String
    var cost: String
    var primaryInfo: String
    var secondaryIndo: String
    var primary: Bool
    var badge: Badge?
    
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
            badge: .preview(alwaysVisible: false)
        )
    }
}

struct Badge: Hashable {
    var id: String
    var title: String
    var alwaysVisible: Bool
    let alignment: Alignment
    
    enum Alignment {
        case top
        case center
        case bottom
    }
    
    static func preview(alwaysVisible: Bool = true) -> Badge {
        return Badge(
            id: UUID().uuidString,
            title: "save 20%",
            alwaysVisible: alwaysVisible,
            alignment: .top
        )
    }
}

struct PaywallNew {
    let options: [Plan]
    let primaryColor: Color = Color(.red)
}

struct Paywall {
    let primaryColor: Color = Color(.systemOrange)
}

struct PlanOptionListView: View {
    let paywall: PaywallNew
    @State var selectedPlan: Plan?
    
    var body: some View {
        ForEach(paywall.options, id: \.id) { plan in
            PlanOptionView(
                selectedPlan: $selectedPlan,
                primaryColor: paywall.primaryColor,
                option: plan
            )
        }
        .scrollDisabled(true)
        .animation(.spring(), value: selectedPlan)
    }
}

struct PlanOptionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlanOptionListView(paywall: PaywallNew(options: [
                .previewMonthly,
                .previewYearly,
            ])).previewLayout(.sizeThatFits)
        }
    }
}
//var body: some View {
//    List(selection: $selectedPlan) {
//        ForEach(paywall.options, id: \.id) { plan in
//            PlanOptionView(
//                selectedPlan: $selectedPlan,
//                primaryColor: paywall.primaryColor,
//                option: plan
//            )
//            .listRowSeparator(.hidden)
//            .listRowBackground(Color.clear)
//            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//        }
//        .navigationTitle(selectedPlan?.name ?? "empty")
//    }
//    .scrollDisabled(true)
//    .listStyle(.plain)
//    .animation(.spring(), value: selectedPlan)
//}
