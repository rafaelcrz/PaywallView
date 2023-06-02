//
//  TitleHeaderView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 02/06/23.
//

import Foundation
import SwiftUI

struct TitleHeaderView: View {
    let primaryHeader: String
    var secondaryHeader: String?
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(primaryHeader)
                    .font(.title)
                if let secondaryHeader = secondaryHeader {
                    Text(secondaryHeader)
                        .foregroundColor(.secondary)
                }
            }
            .fontWeight(.semibold)
            Spacer()
        }
    }
}

struct TitleHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TitleHeaderView(
            primaryHeader: "Primary header",
            secondaryHeader: "Secondary header"
        ).previewLayout(.sizeThatFits)
    }
}
