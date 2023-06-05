//
//  PlanOptionListView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation
import SwiftUI

struct PlanOptionListView: View {
    let primaryColor: Color
    let options: [Plan]
    @Binding var selectedPlan: (Plan)?
    
    var body: some View {
        VStack {
            ForEach(options, id: \.id) { plan in
                PlanOptionView(
                    selectedPlan: $selectedPlan,
                    primaryColor: primaryColor,
                    option: plan
                )
            }
        }
    }
}

struct PlanOptionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlanOptionListView(primaryColor: .pink, options: [
            ], selectedPlan: .constant(.previewYearly)).previewLayout(.sizeThatFits)
        }
    }
}
