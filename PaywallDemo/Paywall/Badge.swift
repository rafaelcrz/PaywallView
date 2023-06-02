//
//  Badge.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

struct Badge: Hashable {
    var id: String
    var title: String
    var alwaysVisible: Bool
    let alignment: Alignment
    var primaryColor: Color
    
    enum Alignment {
        case top
        case center
        case bottom
    }
    
    static func preview(alwaysVisible: Bool = true) -> Badge {
        return Badge(
            id: UUID().uuidString,
            title: "badge title",
            alwaysVisible: alwaysVisible,
            alignment: .top,
            primaryColor: Color(.systemCyan)
        )
    }
}
