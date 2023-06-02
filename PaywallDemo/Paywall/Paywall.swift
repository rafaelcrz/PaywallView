//
//  Paywall.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

enum PlanSectionPresentation {
    case expandable
    case progress
}

final class Paywall: ObservableObject {
    let primaryColor: Color
    let planPresentation: PlanSectionPresentation
    @Published var options: [Plan] = []
    @Published var actionButtonPrimaryTitle: String?
    
    init(primaryColor: Color, planPresentation: PlanSectionPresentation = .progress) {
        self.primaryColor = primaryColor
        self.planPresentation = planPresentation
    }
}
