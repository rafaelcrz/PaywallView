//
//  PlanOptionListView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation
import SwiftUI

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
