//
//  PaywallDemoApp.swift
//  PaywallDemo
//
//  Created by James Sedlacek on 12/15/22.
//

import SwiftUI

@main
struct PaywallDemoApp: App {
    var body: some Scene {
        WindowGroup {
            PageView()
        }
    }
}

struct PageView: View {
    @State private var showingPaywall: Bool = false
    
    @StateObject var paywallConfig: Paywall = .init(
        primaryColor: .red,
        cancelType: .button,
        featureType: .list,
        planPresentation: .progress,
        primaryHeader: "Primary header",
        secondaryHeader: "Secondary header",
        actionButtonPrimaryTitle: "Primary action title"
    )
    
    var body: some View {
        Button("Pro access") {
            showingPaywall.toggle()
        }
        .sheet(isPresented: $showingPaywall) {
            PaywallView(paywall: paywallConfig) { plan in
                showingPaywall = false
            }
        }
        .onChange(of: showingPaywall) { newValue in
            if showingPaywall {
                load()
            }
        }
    }
    
    private func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.paywallConfig.options = [
                .previewMonthly,
                .previewYearly,
                .init(id: "sd", name: "Weekly", cost: "123", primaryInfo: "8 days free", secondaryIndo: "", primary: false),
                .previewMonthly
            ]
        })
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
