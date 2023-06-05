//
//  PaywallDemoApp.swift
//  PaywallDemo
//
//  Created by James Sedlacek on 12/15/22.
//

import SwiftUI
import PaywallView

extension Badge {
    static func preview(alwaysVisible: Bool = true) -> Badge {
        return Badge(
            id: UUID().uuidString,
            title: "badge",
            alwaysVisible: alwaysVisible,
            alignment: .top,
            primaryColor: Color(.systemCyan)
        )
    }
}

extension Plan {
    static var previewMonthly: Plan {
        return Plan(
            id: "monthly",
            name: "Monthly",
            cost: "R$ 4.99",
            primaryInfo: "7 days free trial",
            secondaryIndo: "($4.17/mo)",
            primary: true,
            badge: .preview()
        )
    }

    static var previewYearly: Plan {
        return Plan(
            id: "yearly",
            name: "Yearly",
            cost: "R$ 214.99",
            primaryInfo: "7 days free trial",
            secondaryIndo: "($4.17/mo)",
            primary: true,
            badge: .preview(alwaysVisible: false),
            actionButtonPrimaryTitle: "Action plan title"
        )
    }
}

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
                .previewYearly,
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
