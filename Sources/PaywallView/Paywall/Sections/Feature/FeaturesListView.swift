//
//  FeaturesListView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 05/06/23.
//

import Foundation
import SwiftUI

struct FeaturesListView: View {
    let features: [FeatureCard] = [
        .automaticBackups,
        .biometricsLock,
        .customTags,
        .moreStats,
        .unlimitedEntries,
        .automaticBackups,
        .unlimitedGoals
    ]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(features, id: \.self) { feature in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text(feature.title)
                        .padding(.leading)
                    Spacer()
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(
                            .white.opacity(0.6),
                            .secondary.opacity(0.4))
                            .hidden()
                }.padding(.bottom, 1)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

struct FeaturesViewy_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListView()
            .previewLayout(.sizeThatFits)
    }
}

