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

public struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlan: (Plan)?
    
    public var paywall: Paywall
    @State public var options: [Plan]
    public var actionPurchase: (Plan) -> ()

    public init(
        paywall: Paywall,
        options: [Plan] = [],
        actionPurchase: @escaping (Plan) -> ()
    ) {
        self.paywall = paywall
        self.actionPurchase = actionPurchase
        self._options = .init(wrappedValue: options)
    }
    
    public var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                    ScrollView {
                        VStack(alignment: .center, spacing: 0) {
                            HStack {
                                Group {
                                    if paywall.cancelType == .button {
                                        Image.xmarkCircleIcon
                                            .font(.title3)
                                            .foregroundStyle(
                                                Color.white.opacity(0.6),
                                                Color.secondary.opacity(0.4)
                                            )
                                    } else {
                                        Text("Not now")
                                    }
                                }.onTapGesture {
                                    dismiss()
                                }
                                Spacer()
                            }
                            .padding(.bottom)
                            .padding(.bottom)
                            
                            if paywall.primaryHeader != nil || paywall.secondaryHeader != nil {
                                TitleHeaderView(
                                    primaryHeader: paywall.primaryHeader ?? "",
                                    secondaryHeader: paywall.secondaryHeader ?? ""
                                )
                                .padding(.top, -16)
                                .padding(.bottom)
                            }
                            
                            Group {
                                switch paywall.featureType {
                                case .list:
                                    FeaturesListView()
                                case .carrousel:
                                    carouselSection()
                                }
                            }.padding(.bottom)
                            
                            //                            Spacer()
                            
                            Group {
                                Text("Pro access to all features")
                                    .padding(.bottom)
                                switch paywall.planPresentation {
                                case .progress:
                                    planOptionsProgressPresentationView
                                case .expandable:
                                    planOptionListView
                                }
                            }
                            
                            Spacer()
                            
                            actionButton
                                .padding(.bottom)
                            
                            //                            Label("Purchases share between family members.", systemImage: "person.circle.fill")
                            //                                .font(.caption2)
                            //                                .foregroundColor(.secondary)
                            //                                .padding(.top)
                            
                            restorePurchasesButton()
                                .padding(.bottom)
                            
                            HStack(spacing: 16) {
                                Link("Restore purchases", destination: URL(string: "www.google.com")!)
                                Link("Terms", destination: URL(string: "www.google.com")!)
                                Link("Privacy", destination: URL(string: "www.google.com")!)
                            }
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .padding(.bottom)
                        }
                        .frame(minHeight: geometry.size.height)
                        .animation(.spring(), value: options)
                        .padding()
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
    }
    
    private var planOptionListView: some View {
        PlanOptionListView(
            primaryColor: paywall.primaryColor,
            options: options,
            selectedPlan: $selectedPlan
        )
    }
    
    private var planOptionsProgressPresentationView: some View {
        Group {
            if options.isEmpty {
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
                actionPurchase(selectedPlan)
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
        .disabled(selectedPlan == nil)
        .animation(.easeIn, value: selectedPlan)
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
    
    @State static var options: [Plan] = [
        .previewYearly,
        .previewMonthly,
        .previewYearly
    ]
    
    static var previews: some View {
        
        return PaywallView(paywall: paywall, options: options, actionPurchase: {_ in
            
        })
    }
}
