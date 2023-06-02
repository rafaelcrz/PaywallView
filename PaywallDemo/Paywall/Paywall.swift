//
//  Paywall.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

final class Paywall: ObservableObject {
    var primaryColor: Color
    @Published var options: [Plan] = []
    @Published var actionButtonPrimaryTitle: String?
    
    init(primaryColor: Color) {
        self.primaryColor = primaryColor
    }
}
