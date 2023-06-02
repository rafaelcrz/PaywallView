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
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .center) {
                        TitleHeaderView(
                            primaryHeader: paywall.primaryHeader ?? "",
                            secondaryHeader: paywall.secondaryHeader ?? ""
                        ).padding(.top)

                        carouselSection()
                            .padding(.horizontal, -16)
                        
                        Text("Pro access to all features")
                        
                        Group {
                            switch paywall.planPresentation {
                            case .progress:
                                planOptionsProgressPresentationView
                            case .expandable:
                                planOptionsExpandablePresentationView
                            }
                        }
                        
                        actionButton
                        
                        Label("Purchases share between family members.", systemImage: "person.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        restorePurchasesButton()
                            .padding()
                        
                        HStack(spacing: 16) {
                            Link("Terms", destination: URL(string: "www.google.com")!)
                            Link("Privacy", destination: URL(string: "www.google.com")!)
                        }
                        .foregroundColor(.secondary)
                        .font(.caption)
                    }
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
    
    private var planOptionsExpandablePresentationView: some View {
        planOptionListView
            .frame(maxHeight: !paywall.options.isEmpty ? .infinity : 0)
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
        return VStack {
            InfiniteScroller(contentWidth: getContentWidth(), direction: .forward) {
                HStack(spacing: 16) {
                    FeatureCardView(featureCard: .unlimitedEntries)
                    FeatureCardView(featureCard: .importData)
                    FeatureCardView(featureCard: .biometricsLock)
                    FeatureCardView(featureCard: .automaticBackups)
                }.padding(8)
            }
            
            InfiniteScroller(contentWidth: getContentWidth(), direction: .backward) {
                HStack(spacing: 16) {
                    FeatureCardView(featureCard: .customTags)
                    FeatureCardView(featureCard: .moreStats)
                    FeatureCardView(featureCard: .moreDates)
                    FeatureCardView(featureCard: .unlimitedGoals)
                }.padding(8)
            }
        }
    }
    
    private var actionButton: some View {
        Button {
            if let selectedPlan = selectedPlan {
                planSelected?(selectedPlan)
            }
        } label: {
            Text(paywall.actionButtonPrimaryTitle)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.black))
                .padding(10)
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
        actionButtonPrimaryTitle: "teste"
    )
    
    static var previews: some View {
        paywall.options = [
            .previewYearly,
            .previewMonthly
        ]
        
        return PaywallView(paywall: paywall)
    }
}
