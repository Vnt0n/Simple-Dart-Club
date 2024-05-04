//
//  FirstView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct FirstView: View {

    @State private var navigateToGame = false
    @StateObject var viewModel = GameViewModel(gameType: 0)
    @FocusState private var focusedPlayerIndex: Int?
    @State private var showSettingsView = false
    @State private var isTyping = false

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black.ignoresSafeArea(.all)

                VStack {
                    
                    Spacer()
                    
                    if !isTyping {
                        
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
                                .padding(.top, -80)
                            
                        }
                        .transition(.opacity)
                        
                    }
                    
                    ForEach(0..<viewModel.currentGame.players.count, id: \.self) { index in
                        TextField("Player \(index + 1)", text: $viewModel.currentGame.players[index].name)
                            .padding(.horizontal, 50)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 350)
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                            .focused($focusedPlayerIndex, equals: index)
                            .onChange(of: focusedPlayerIndex) {
                                withAnimation {
                                    isTyping = true
                                }
                            }
                        }
                        .font(.title)
                        
                    Spacer()
                    
                    if viewModel.currentGame.players.count < 4 {
                        Button(action: {
                            withAnimation {
                                viewModel.addPlayer()
                                focusedPlayerIndex = viewModel.currentGame.players.count - 1
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
                            
                            Text("or")
                                .font(.system(size: 20))
                            
//                            .padding(.bottom, 55)
                            
                            Button("501") {
                                viewModel.currentGame.gameType = 501
                                viewModel.gameStarted = true
                                navigateToGame = true
                            }
                            .disabled(!canStartGame)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            
//                        .padding(.bottom, 55)

//                    Button(action: {
//                        print("--------------------------------------------")
//                        print("BUTTON SettingsView")
//                        showSettingsView = true
//                        }) {
//                            Image(systemName: "gearshape")
//                                .accessibilityLabel("Undo")
//                                .font(.system(size: 20))
//                        }
//                        .sheet(isPresented: $showSettingsView) {
//                            SettingsView()
//                        }
//                        .padding(.bottom, 55)
                            
                            
//////////////////////////////////////////////////////////////////// DEBUG BUTTON /////////////////////////////////////////////////////////////////

        Button(action: {

            print("--------------------------------------------")
            print("--------------------------------------------")
            print("DEBUG")
            print("--------------------------------------------")
            print("--------------------------------------------")
            print("DOUBLE OUT: \(viewModel.currentGame.isToggledDoubleOut)")
            print(" ")
            print(" ")
            
        }) {
            Image(systemName: "ladybug.circle")
                .accessibilityLabel("Undo")
                .font(.system(size: 25))
        }
                        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            
                        }
                    
                    HStack {

                        Toggle(isOn: $viewModel.currentGame.isToggledDoubleOut) {
                            Text("Double Out")
                                .font(.system(size: 18))
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .frame(width: 200)
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .navigationBarBackButtonHidden(true)
                .interactiveDismissDisabled()
            }
            .navigationDestination(isPresented: $navigateToGame) {
                GameView(selectedGame: viewModel.currentGame.gameType, players: viewModel.currentGame.players, viewModel: viewModel)
            }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .navigationBarBackButtonHidden(true)
                .interactiveDismissDisabled()
            }
            .onAppear {
                print("------------------------------")
                print("STARTING APP")

            }
        }
    
        var canStartGame: Bool {
            !viewModel.currentGame.players.isEmpty && viewModel.currentGame.players.allSatisfy { !$0.name.isEmpty }
        }

}


// ///////////////////////////
// PREVIEW //////////////////

#Preview {
    FirstView()
}
