//
//  MatchMyFlagApp.swift
//  MatchMyFlag
//
//  Created by Sajan Lawrence on 13/11/25.
//

import SwiftUI

@main
struct MatchMyFlagApp: App {
    @State private var viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(viewModel)
        }
    }
}
