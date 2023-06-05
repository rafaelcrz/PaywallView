//
//  PaywallView.swift
//  MyTradingJournal
//
//  Created by James Sedlacek on 11/22/22.
//

import SwiftUI

enum Section {
    case header
    case features
    case products
    case primaryButton
    case tertiaryInfo
    case secondayBurron
}

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedPlan: Plan?
    @StateObject var paywall: Paywall
    var planSelected: ((Plan) -> Void)?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                    ScrollView {
                        VStack(alignment: .center, spacing: 0) {
                            if paywall.primaryHeader != nil || paywall.secondaryHeader != nil {
                                TitleHeaderView(
                                    primaryHeader: paywall.primaryHeader ?? "",
                                    secondaryHeader: paywall.secondaryHeader ?? ""
                                )
                                .padding(.top, -16)
                                .padding(.bottom)
                            }
                            
                            FeaturesView()
                            //                                .padding(.horizontal, -16)
                            //                            carouselSection()
                            //                                .padding(.horizontal, -16)
                            Spacer()
                            
                            Group {
                                Text("Pro access to all features")
                                switch paywall.planPresentation {
                                case .progress:
                                    planOptionsProgressPresentationView
                                case .expandable:
                                    planOptionListView
                                }
                            }.padding(.top)
                            
                            actionButton
                                .padding(.top)
                            
                            Label("Purchases share between family members.", systemImage: "person.circle.fill")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.top)
                            
                            restorePurchasesButton()
                                .padding()
                            
                            HStack(spacing: 16) {
                                Link("Terms", destination: URL(string: "www.google.com")!)
                                Link("Privacy", destination: URL(string: "www.google.com")!)
                            }
                            .foregroundColor(.secondary)
                            .font(.caption)
                        }
                        .frame(minHeight: geometry.size.height)
                        .animation(.spring(), value: paywall.options)
                        .padding()
                        .if(paywall.cancelType == .button, { view in
                            view.toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image.xmarkCircleIcon
                                            .font(.title3)
                                            .foregroundStyle(
                                                Color.white.opacity(0.6),
                                                Color.secondary.opacity(0.4)
                                            )
                                    }
                                    
                                }
                            }
                        })
                    }.frame(width: geometry.size.width)
                }
            }
        }
    }
    
    private var planOptionListView: some View {
        PlanOptionListView(
            primaryColor: paywall.primaryColor,
            options: paywall.options,
            selectedPlan: $selectedPlan
        )
    }
    
    private var planOptionsProgressPresentationView: some View {
        Group {
            if paywall.options.isEmpty {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 200)
                    .overlay {
                        ProgressView("")
                            .progressViewStyle(.circular)
                    }
            } else {
                planOptionListView
            }
        }
    }
    
    private func carouselSection() -> some View {
        InfiniteScroller(contentWidth: getContentWidth(), direction: .forward) {
            HStack(spacing: 16) {
                FeatureCardView(featureCard: .unlimitedEntries)
                FeatureCardView(featureCard: .importData)
                FeatureCardView(featureCard: .biometricsLock)
                FeatureCardView(featureCard: .automaticBackups)
            }.padding(8)
        }
    }
    
    private var actionButton: some View {
        Button {
            if let selectedPlan = selectedPlan {
                planSelected?(selectedPlan)
            }
        } label: {
            Text(selectedPlan?.actionButtonPrimaryTitle ?? paywall.actionButtonPrimaryTitle)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.black))
                .padding(10)
                .animation(.spring(), value: selectedPlan?.actionButtonPrimaryTitle)
        }
        .padding(.horizontal)
        .tint(paywall.primaryColor)
        .buttonStyle(.borderedProminent)
    }
    
    private func restorePurchasesButton() -> some View {
        Button {
            
        } label: {
            Text("Restore Purchases")
                .font(.caption)
        }
    }
    
    private func getContentWidth() -> CGFloat {
        let cardWidth: CGFloat = 90
        let spacing: CGFloat = 16
        let padding: CGFloat = 8
        let contentWidth: CGFloat = (cardWidth * 4) + (spacing * 9) + padding
        return contentWidth
    }
}

struct PaywallView_Previews: PreviewProvider {
    static var paywall = Paywall(
        primaryColor: Color(.systemPink),
        planPresentation: .progress,
        primaryHeader: nil,
        secondaryHeader: nil,
        actionButtonPrimaryTitle: "teste"
    )
    
    static var previews: some View {
        paywall.options = [
            .previewYearly,
            .previewMonthly,
            .previewYearly
        ]
        
        return PaywallView(paywall: paywall)
    }
}

struct FeaturesView: View {
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
                }.padding(.bottom,4)
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

struct FeaturesViewy_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesView()
            .previewLayout(.sizeThatFits)
    }
}
