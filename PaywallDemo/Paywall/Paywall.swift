//
//  Paywall.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

enum FeatureType {
    case list
    case carrousel
}

enum PlanSectionPresentation {
    case expandable
    case progress
}

final class Paywall: ObservableObject {
    var primaryColor: Color
    var featureType: FeatureType = .list
    var planPresentation: PlanSectionPresentation = .progress
    var primaryHeader: String?
    var secondaryHeader: String?
    var actionButtonPrimaryTitle: String
    var cancelType: CancelType
    @Published var options: [Plan] = []
    
    init(
        primaryColor: Color,
        cancelType: CancelType = .button,
        featureType: FeatureType = .list,
        planPresentation: PlanSectionPresentation,
        primaryHeader: String? = nil,
        secondaryHeader: String? = nil,
        actionButtonPrimaryTitle: String
    ) {
        self.primaryColor = primaryColor
        self.cancelType = cancelType
        self.featureType = featureType
        self.planPresentation = planPresentation
        self.primaryHeader = primaryHeader
        self.secondaryHeader = secondaryHeader
        self.actionButtonPrimaryTitle = actionButtonPrimaryTitle
    }
}
