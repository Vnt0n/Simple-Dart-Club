//
//  FirstView.swift
//  Simple Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct FirstView: View {
    @State private var navigateToGame = false
    @StateObject var viewModel = GameViewModel(gameType: 0)
    @FocusState private var focusedPlayerIndex: Int?
    
    @AppStorage("appLanguage") var appLanguage: String = Locale.preferredLanguages.first ?? "en"
    @State private var isShowingLanguageSetting = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color.black.ignoresSafeArea(.all)
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        
                        if geometry.size.width > 1050 {
                            HStack {
                                Spacer()
                                dartClubText
                                    .padding(.leading, 155)
                                Spacer()
                                mainContentVStack
                                Spacer()
                            }
                            
                        } else {
                            VStack {
                                dartClubText
                                    .padding(.top, 80)
                                mainContentVStack
                            }
                        }
                        
                    } else {
                        VStack {
                            if geometry.size.height > 550 {
                                dartClubText
                            }
                            mainContentVStack
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .navigationBarBackButtonHidden(true)
                .interactiveDismissDisabled()
                .navigationDestination(isPresented: $navigateToGame) {
                    GameView(selectedGame: viewModel.currentGame.gameType, players: viewModel.currentGame.players, viewModel: viewModel)
                }
                .statusBarHidden(true)
            }
            .preferredColorScheme(.dark)
            .sheet(isPresented: $isShowingLanguageSetting) {
                LanguageSettingView()
            }
        }
        .environment(\.locale, Locale(identifier: appLanguage))
    }

    var dartClubText: some View {
        VStack {
            // Utilisation de focusedPlayerIndex pour ajuster la taille de la police
            Text("Dart   ")
                .font(Font
                    .custom("FightThis", size: focusedPlayerIndex != nil && UIDevice.current.userInterfaceIdiom == .pad ? 130 : (UIDevice.current.userInterfaceIdiom == .pad ? 145 : 84)))
                .shadow(color: Color.red, radius: 15)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .rotationEffect(Angle(degrees: 347))
                .padding([.trailing], 40)
                .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? -50 : -20)

            Text("Simple   ")
                .font(Font
                    .custom("FightThis", size: focusedPlayerIndex != nil && UIDevice.current.userInterfaceIdiom == .pad ? 36 : (UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20)))
                .shadow(color: Color.red, radius: 15)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .rotationEffect(Angle(degrees: 347))
                .padding([.trailing], 30)

            Text("Club   ")
                .font(Font
                    .custom("FightThis", size: focusedPlayerIndex != nil && UIDevice.current.userInterfaceIdiom == .pad ? 130 : (UIDevice.current.userInterfaceIdiom == .pad ? 145 : 84)))
                .shadow(color: Color.red, radius: 15)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .rotationEffect(Angle(degrees: 347))
                .padding([.trailing], 40)
                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? -70 : -33)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.3), value: focusedPlayerIndex)
    }

    var mainContentVStack: some View {
        VStack {
            Spacer()
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                playerFieldsTwoRows
            } else {
                playerFieldsOneRow
            }
            
            if viewModel.currentGame.players.count < 4 {
                HStack {
                    playerAddButton
                    if viewModel.currentGame.players.count > 1 {
                        playerRemoveButton
                            .padding(.top, 15)
                            .padding(.leading, 15)
                    }
                }
            } else if viewModel.currentGame.players.count == 4 {
                HStack {
                    playerRemoveButton
                        .padding(.top, 15)
                }
            }
            
            Spacer()
            gameControls
            settingsToggle
            languageSettingsButton
            Spacer()
        }
    }
    
    var languageSettingsButton: some View {
        Button(action: {
            isShowingLanguageSetting.toggle()
        })  {
            Label {
                Text("Change language")
                    .font(.system(size: 15))

            } icon: {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Change language")
    }

    var playerFieldsTwoRows: some View {
        VStack {
            HStack {
                playerTextField(index: 0)
                if viewModel.currentGame.players.count > 1 {
                    playerTextField(index: 1)
                }
            }
            HStack {
                if viewModel.currentGame.players.count > 2 {
                    playerTextField(index: 2)
                }
                if viewModel.currentGame.players.count > 3 {
                    playerTextField(index: 3)
                }
            }
        }
    }
        
    var playerFieldsOneRow: some View {
        ForEach(0..<viewModel.currentGame.players.count, id: \.self) { index in
            playerTextField(index: index)

        }
    }

    private func playerTextField(index: Int) -> some View {
        TextField("Player \(index + 1)", text: $viewModel.currentGame.players[index].name)
            .padding(.horizontal, 10)
            .textFieldStyle(.roundedBorder)
            .frame(width: 250)
            .multilineTextAlignment(.center)
            .disableAutocorrection(true)
            .foregroundColor(.primary)
            .focused($focusedPlayerIndex, equals: index)
            .accessibilityLabel("Enter player \(index + 1) name")
    }

    var playerAddButton: some View {
        Button(action: {
            withAnimation {
                viewModel.addPlayer()
                focusedPlayerIndex = viewModel.currentGame.players.count - 1
            }
        }) {
            Label("Add", systemImage: "person.fill.badge.plus")
                .font(.system(size: 18))
                .padding(.top, 20)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("Add a player")
        
    }

    var gameControls: some View {
        HStack {
            Button("301") {
                viewModel.currentGame.gameType = 301
                viewModel.gameStarted = true
                navigateToGame = true
            }
            .disabled(!canStartGame)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityLabel("301 mode")

            Text("or").font(.system(size: 20))

            Button("501") {
                viewModel.currentGame.gameType = 501
                viewModel.gameStarted = true
                navigateToGame = true
            }
            .disabled(!canStartGame)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityLabel("501 mode")

        }
        .padding(.bottom, -10)
    }

    var settingsToggle: some View {
        Toggle(isOn: $viewModel.currentGame.isToggledDoubleOut) {
            Text("Double Out").font(.system(size: 18))
        }
        .padding()
        .frame(width: 200)
        .accessibilityLabel("Double Out option")
    }
    
    var canStartGame: Bool {
        !viewModel.currentGame.players.isEmpty && viewModel.currentGame.players.allSatisfy { !$0.name.isEmpty }
    }
    
    var playerRemoveButton: some View {
        ZStack {
            if viewModel.currentGame.players.count > 1 {
                Button(action: {
                    withAnimation {
                        viewModel.removeLastPlayer()
                    }
                }) {
                    HStack {
                        if viewModel.currentGame.players.count == 4 {
                            Text("Remove a player")
                                .font(.system(size: 18))
                                .foregroundColor(.red)
                        }
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    }
                    .accessibilityLabel("Remove last player")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
   
}


// ///////////////////////////
// PREVIEW //////////////////

#Preview {
    FirstView()
}
