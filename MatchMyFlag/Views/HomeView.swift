//
//  HomeView.swift
//  MatchMyFlag
//
//  Created by Sajan Lawrence on 13/11/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @State private var showSheet: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                ZStack{
                    RadialGradient(colors: [.blue, .black], center: .center, startRadius: 0, endRadius: 500)
                        .ignoresSafeArea()
                    Circle()
                        .offset(x: -100, y: -500)
                        .foregroundStyle(RadialGradient(colors: [.blue, .black], center: .center, startRadius: 0, endRadius: 600))
                    Circle()
                        .offset(x: 50, y: 500)
                        .foregroundStyle(RadialGradient(colors: [.blue, .black], center: .center, startRadius: 0, endRadius: 600))
                    Circle()
                        .offset(x: 300, y: 0)
                        .foregroundStyle(RadialGradient(colors: [.blue, .black], center: .center, startRadius: 0, endRadius: 600))
                    
                }
                VStack{
                    VStack{
                        Text("Match My Flag")
                            .foregroundStyle(.white)
                            .font(.title)
                            .bold()
                        Text("Flip cards, find matching flags, and complete all the pairs as fast as you can!")
                            .foregroundStyle(.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .italic()
                        
                    }
                    .padding(.vertical, 20)
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(viewModel.countries) { item in
                            CardView(country: item)
                                .shadow(radius: 20)
                        }
                    }
                    Text("Moves: \(viewModel.totalTries)")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                }
                .padding(.vertical)
            }
            .onAppear(perform: viewModel.getRandomCountries)
            .onChange(of: viewModel.matchedItems) { _, newValue in
                if newValue.count == 5{
                    viewModel.saveLatestScore()
                    showSheet.toggle()
                }
            }
            .alert(isPresented: $showSheet) {
                Alert(title: Text("Congrats🥳🥳🥳"), message: Text("You took \(viewModel.totalTries) moves to finish the game"), dismissButton: .default(Text("Close")))
                
            }
            .alert("Congrats🥳🥳🥳", isPresented: $showSheet) {
                Button("Restart") {
                    viewModel.restartGame()
                }
            } message: {
                Text("You took \(viewModel.totalTries) moves to finish the game. Your Personal best is \(viewModel.getHighestScore()) moves")
                    .multilineTextAlignment(.center)
            }
            
            
        }
    }
}

#Preview {
    @Previewable @State var viewModel = HomeViewModel()
    HomeView()
        .environment(viewModel)
}
