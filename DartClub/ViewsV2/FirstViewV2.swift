//
//  FirstViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct FirstViewV2: View {

    @StateObject var viewModel = GameViewModel(gameType: 301, playerCount: 4)  // Default to 301 game type
    @State private var numberOfPlayers = 1
    @State private var navigateToGame = false  // Contrôle la navigation

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black.ignoresSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Dart   ")
                        .font(Font.custom("FightThis", size: 84))
                        .shadow(color: Color.red, radius: 15)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .rotationEffect(Angle(degrees: 347))
                        .frame(maxWidth: .infinity)
                        .padding([.trailing], 40)
                    
                    Text("Club   ")
                        .font(Font.custom("FightThis", size: 84))
                        .shadow(color: Color.red, radius: 15)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .rotationEffect(Angle(degrees: 347))
                        .frame(maxWidth: .infinity)
                        .padding([.trailing], 40)
                        .padding(.top, -80)
                    
                    Spacer()
                    
                    ForEach(0..<numberOfPlayers, id: \.self) { index in
                        TextField("Player \(index + 1)", text: $viewModel.currentGame.players[index].name)
                            .TextFieldStyling()
                        
                    }
                    .font(.title)
                    
                    Spacer()
                    
                    
                    
                    if numberOfPlayers < 4 {
                        Button(action: {
                            withAnimation {
                                numberOfPlayers += 1
                                viewModel.currentGame.players.append(Player())
                            }
                        }) {
                            Label("Add a player", systemImage: "person.fill.badge.plus")
                                .accessibilityLabel("Add a player")
                                .font(.system(size: 20))
                                .padding(.top, 20)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                                            Button("301") {
                                                viewModel.currentGame.gameType = 301
                                                viewModel.gameStarted = true
                                                navigateToGame = true
                                            }
                                            .disabled(!canStartGame)
                                            .buttonStyle(.borderedProminent)
                                            .controlSize(.large)
                                            .padding(.bottom, 55)

                                            Text("or").font(.system(size: 20)).padding(.bottom, 55)

                                            Button("501") {
                                                viewModel.currentGame.gameType = 501
                                                viewModel.gameStarted = true
                                                navigateToGame = true
                                            }
                                            .disabled(!canStartGame)
                                            .buttonStyle(.borderedProminent)
                                            .controlSize(.large)
                                            .padding(.bottom, 55)
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .navigationBarBackButtonHidden(true)
                                    .interactiveDismissDisabled()
                                }
            .navigationDestination(isPresented: $navigateToGame) {
                GameViewV2(selectedGame: viewModel.currentGame.gameType, players: viewModel.currentGame.players, viewModel: viewModel)
            }

                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .navigationBarBackButtonHidden(true)
                .interactiveDismissDisabled()
            }
        }
        var canStartGame: Bool {
            numberOfPlayers > 0 && viewModel.currentGame.players.prefix(numberOfPlayers).allSatisfy { !$0.name.isEmpty }
        }

}


#Preview {
    FirstViewV2()
}
