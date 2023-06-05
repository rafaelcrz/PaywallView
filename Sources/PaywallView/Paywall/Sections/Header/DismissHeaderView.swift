//
//  DismissHeaderView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation
import SwiftUI

public enum CancelType: Equatable {
    case button
    case text(String)
    
    public static func == (lhs: CancelType, rhs: CancelType) -> Bool {
        if case .button = lhs, case .button = rhs {
            return true
        }
        
        if case .text(let string1) = lhs, case .text(let string2) = rhs {
            return string1 == string2
        }
        
        return false
    }
}

struct DismissHeaderView: View {
    let type: CancelType
    var action: () -> ()
    var body: some View {
        Group {
            if case .text(let title) = type {
                Text(title)
            } else {
                Image.xmarkCircleIcon
                    .foregroundStyle(
                        Color.white.opacity(0.6),
                        Color.secondary.opacity(0.4)
                    )
            }
        }.foregroundColor(.secondary)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DismissHeaderView(type: .button, action: {})
            .previewLayout(.sizeThatFits)
    }
}
