//
//  PlanOptionView.swift
//  PaywallDemo
//
//  Created by Rafael Ramos on 01/06/23.
//

import Foundation
import SwiftUI

struct PlanOptionView: View {
    @Binding var selectedPlan: Plan?
    var primaryColor: Color
    let option: Plan
    
    var body: some View {
        ZStack {
            HStack {
                checkMarkIconView
                    .font(.title)
                    .foregroundColor(primaryColor)
                
                descriptionPriceView
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedPlan?.id == option.id ? primaryColor : Color.clear, lineWidth: 4)
            )
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(12)
            
            if let badge = option.badge {
                badgeView(badge)
            }
        }
        .onTapGesture { selectedPlan = option }
    }
}

private extension PlanOptionView {
    var checkMarkIconView: Image {
        selectedPlan?.id == option.id ? Image.checkmarkCircleIcon : Image.circleIcon
    }
    
    var descriptionPriceView: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack(spacing: 2) {
                    Text(option.name)
                        .font(.callout)
                    Text("*")
                        .foregroundColor(.secondary)
                    Text(option.cost)
                        .font(.callout)
                }
                .fontWeight(.semibold)
                Text(option.secondaryIndo)
                    .font(.caption)
                    .fontWeight(.semibold)
                Spacer()
            }
            Text(option.primaryInfo)
                .font(.callout)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
        }
    }
    
    func badgeView(_ badge: Badge) -> some View {
        VStack {
            if badge.alignment == .bottom {
                Spacer()
            }
            HStack {
                Spacer()
                Text(badge.title)
                    .font(.system(size: 14, weight: .medium))
                    .padding(8)
                    .background(badge.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .opacity((selectedPlan?.id == option.id || badge.alwaysVisible) ? 1 : 0)
            }
            if badge.alignment == .top {
                Spacer()
            }
        }
        .frame(height: 80)
    }
}

struct PlanOptionView_Previews: PreviewProvider {
    @State static var selectedPlan: Plan?
    static var previews: some View {
        PlanOptionView(
            selectedPlan: .constant(.previewMonthly),
            primaryColor: Color(.systemGreen),
            option: .previewMonthly
        ).previewLayout(.sizeThatFits)
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, _ transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

