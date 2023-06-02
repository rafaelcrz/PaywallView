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
    var body: some View {
        Button("Pro access") {
            showingPaywall.toggle()
        }.sheet(isPresented: $showingPaywall) {
            PaywallView()
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
