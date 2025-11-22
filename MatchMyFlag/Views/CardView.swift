//
//  CardView.swift
//  MatchMyFlag
//
//  Created by Sajan Lawrence on 13/11/25.
//

import SwiftUI

struct CardView: View {
    let country: Country
    @Environment(HomeViewModel.self) private var viewModel
    @State private var rotate: Bool = false
    var isFound: Bool{
        viewModel.matchedItems.contains(where: { $0 == country })
    }
    @State private var open: Bool = false
    var body: some View {
        ZStack{
            Image(country.name)
                .resizable()
                .clipShape(.capsule)
                .opacity(rotate ? 1 : 0)
            
            Rectangle()
                .clipShape(.capsule)
                .opacity(rotate ? 0 : 1)
                .foregroundStyle(.ultraThinMaterial)
        }
        .frame(width: 180, height: 100)
        .rotation3DEffect(.degrees(rotate ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            if isFound || viewModel.shouldWait || open{
                return
            }
            if viewModel.shouldOpenCard(){
                withAnimation {
                    open = true
                    rotate.toggle()
                    viewModel.didSelectCard(with: country)
                }
            }
        }
        .onChange(of: viewModel.isCompletedCheck, { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        if open && !isFound{
                            open = false
                            rotate.toggle()
                        }
                        viewModel.shouldWait = false
                    }
                }
            }
        })
    }
}

#Preview {
    @Previewable @State var viewModel = HomeViewModel()
    CardView(country: .default)
        .environment(viewModel)
}
