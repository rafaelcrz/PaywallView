//
//  Badge.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation

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
