//
//  FirstViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct Player {
    var name: String = ""
    var isNameSubmitted: Bool = false
}

struct FirstViewV2: View {
    @State private var players = Array(repeating: Player(), count: 4)
    @State private var numberOfPlayers = 1
    @State private var gameStarted = false
    @State private var selectedGame: Int?

    @FocusState private var focusedPlayerIndex: Int?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack {
                    
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

                    Spacer()

                    ForEach(0..<numberOfPlayers, id: \.self) { index in
                        TextField("Player \(index + 1)", text: $players[index].name)
                            .TextFieldStyling()
                            .focused($focusedPlayerIndex, equals: index)
                            .onSubmit {
                                players[index].isNameSubmitted = true
                                focusedPlayerIndex = (index + 1 < numberOfPlayers) ? index + 1 : nil
                                print("Player \(index + 1) submitted: \(players[index].name)")
                            }
                            .font(.title)
                        
                        Spacer()
                        
                    }

                    if numberOfPlayers < 4 {
                        Button(action: {
                            withAnimation {
                                numberOfPlayers += 1
                                focusedPlayerIndex = numberOfPlayers - 1
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
                            selectedGame = 301
                            gameStarted = true
                        }
                        .disabled(!canStartGame)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 55)
                        .navigationDestination(isPresented: $gameStarted) {
                            GameViewV2(selectedGame: selectedGame, players: players)
                        }

                        Text("or")
                            .font(.system(size: 20))
                            .padding(.bottom, 55)

                        Button("501") {
                            selectedGame = 501
                            gameStarted = true
                        }
                        .disabled(!canStartGame)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 55)
                        .navigationDestination(isPresented: $gameStarted) {
                            GameViewV2(selectedGame: selectedGame, players: players)
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .navigationBarBackButtonHidden(true)
                .interactiveDismissDisabled()
            }
        }
    }

    var canStartGame: Bool {
        if numberOfPlayers < 1 {
            return false
        }
        return players.prefix(numberOfPlayers).allSatisfy { !$0.name.isEmpty }
    }

}


#Preview {
    FirstViewV2()
}
