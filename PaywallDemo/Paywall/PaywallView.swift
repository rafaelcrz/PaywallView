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
    
    @StateObject var paywall: Paywall = Paywall(
        primaryColor: Color(.systemMint),
        planPresentation: .expandable
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .center) {
                        DismissHeaderView(type: .button, action: {
                            dismiss()
                        })
                        
                        TitleHeaderView(
                            primaryHeader: "Primary header",
                            secondaryHeader: "secondary header"
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
                    }
                    .animation(.spring(), value: paywall.options)
                    .padding()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.paywall.options = [
                    .previewMonthly,
                    .previewYearly
                ]
            })
        }
    }
    
    private var planOptionListView: some View {
        PlanOptionListView(
            primaryColor: paywall.primaryColor,
            options: paywall.options
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
                        ProgressView("Loading plans")
                            .progressViewStyle(.circular)
                    }
            } else {
                planOptionListView
            }
        }
    }
    
    private func headerSection() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    //                    Image.xmarkCircleIcon
                    //                        .font(.title3)
                    //                        .opacity(0.5)
                    Text("Not Now")
                }
                .foregroundColor(.secondary)
                .padding(.bottom)
                Spacer()
            }
            Text("Pro access to all features")
                .font(.title)
                .fontWeight(.semibold)
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
            
        } label: {
            Text("Start Free Trial")
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.black))
                .padding(10)
        }
        .padding(.horizontal)
        .tint(paywall.primaryColor)
        .buttonStyle(.borderedProminent)
    }
    
    private func restorePurchasesButton() -> some View {
        return Button {
            // TODO: action
        } label: {
            Text("Restore Purchases")
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
    static var previews: some View {
        PaywallView()
    }
}
