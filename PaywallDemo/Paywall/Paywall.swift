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
    var primaryColor: Color
    var planPresentation: PlanSectionPresentation = .progress
    var primaryHeader: String?
    var secondaryHeader: String?
    var actionButtonPrimaryTitle: String
    @Published var options: [Plan] = []
    
    init(
        primaryColor: Color,
        planPresentation: PlanSectionPresentation,
        primaryHeader: String? = nil,
        secondaryHeader: String? = nil,
        actionButtonPrimaryTitle: String
    ) {
        self.primaryColor = primaryColor
        self.planPresentation = planPresentation
        self.primaryHeader = primaryHeader
        self.secondaryHeader = secondaryHeader
        self.actionButtonPrimaryTitle = actionButtonPrimaryTitle
    }
}
