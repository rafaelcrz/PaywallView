//
//  DismissHeaderView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation
import SwiftUI

enum CancelType {
    case button
    case text(String)
}

struct DismissHeaderView: View {
    let type: CancelType
    var action: () -> ()
    var body: some View {
        HStack(alignment: .center) {
            Button {
                action()
            } label: {
                if case .text(let title) = type {
                    Text(title)
                } else {
                    Image.xmarkCircleIcon
                        .font(.title)
                        .foregroundStyle(
                            Color.white.opacity(0.6),
                            Color.secondary.opacity(0.4)
                        )
                }
            }
            .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DismissHeaderView(type: .button, action: {})
            .previewLayout(.sizeThatFits)
    }
}
