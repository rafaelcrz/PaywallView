//
//  Badge.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

public struct Badge: Hashable, Equatable {
    let id: String
    let title: String
    let alwaysVisible: Bool
    let alignment: Alignment
    let primaryColor: Color
    
    public init(
        id: String,
        title: String,
        alwaysVisible: Bool,
        alignment: Alignment,
        primaryColor: Color
    ) {
        self.id = id
        self.title = title
        self.alwaysVisible = alwaysVisible
        self.alignment = alignment
        self.primaryColor = primaryColor
    }
    
    public enum Alignment {
        case top
        case center
        case bottom
    }
    
    static func preview(alwaysVisible: Bool = true) -> Badge {
        return Badge(
            id: UUID().uuidString,
            title: "badge",
            alwaysVisible: alwaysVisible,
            alignment: .top,
            primaryColor: Color(.systemCyan)
        )
    }
}
