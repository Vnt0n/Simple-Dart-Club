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
            }
            .preferredColorScheme(.dark)
            .statusBar(hidden: true)
            .sheet(isPresented: $isShowingLanguageSetting) {
                LanguageSetting()
            }
        }
        .environment(\.locale, Locale(identifier: appLanguage))
    }

    var dartClubText: some View {
        VStack {
            
            Text("Dart   ")
                .font(Font
                    .custom("FightThis", size: UIDevice.current.userInterfaceIdiom == .pad ? 145 : 84))
            .shadow(color: Color.red, radius: 15)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .rotationEffect(Angle(degrees: 347))
            .padding([.trailing], 40)
            .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? -50 : -20)
        
            Text("Simple   ")
                .font(Font
                    .custom("FightThis", size: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20))
            .shadow(color: Color.red, radius: 15)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .rotationEffect(Angle(degrees: 347))
            .padding([.trailing], 30)
            
            Text("Club   ")
                .font(Font
                    .custom("FightThis", size: UIDevice.current.userInterfaceIdiom == .pad ? 145 : 84))
            .shadow(color: Color.red, radius: 15)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .rotationEffect(Angle(degrees: 347))
            .padding([.trailing], 40)
            .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? -70 : -33)
            
        }
        .transition(.opacity)
    }

    var mainContentVStack: some View {
        VStack {
            Spacer()
            if UIDevice.current.userInterfaceIdiom == .pad {
                playerFieldsTwoRows
            } else {
                playerFieldsOneRow
            }
            if viewModel.currentGame.players.count < 4 && UIDevice.current.userInterfaceIdiom == .phone || viewModel.currentGame.players.count < 4 && UIDevice.current.userInterfaceIdiom == .pad && viewModel.currentGame.players.count != 3 {
                HStack {
                    addButton
                    playerDeleteButton
                        .padding(.top, 15)
                        .padding(.leading, 15)
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
            isShowingLanguageSetting.toggle() // Basculer l'état pour afficher la feuille
        })  {
            Label {
                Text("Change language")
                    .font(.system(size: 15))

            } icon: {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.bottom, 20) // Placer en bas de la vue
            .frame(maxWidth: .infinity, alignment: .center) // Centrer le bouton
        }
    }

    var playerFieldsTwoRows: some View {
        VStack {
            HStack {
                if viewModel.currentGame.players.count > 0 {
                    playerTextField(index: 0)
                }
                if viewModel.currentGame.players.count > 1 {
                    playerTextField(index: 1)
                }
            }

            HStack {
                if viewModel.currentGame.players.count > 2 {
                    playerTextField(index: 2)
                }
                if viewModel.currentGame.players.count == 3 && UIDevice.current.userInterfaceIdiom == .pad {
                    HStack {
                        addButton
                        playerDeleteButton
                            .padding(.top, 15)
                            .padding(.leading, 15)
                    }
                    .frame(width: 250)
                    .padding(.bottom, 15)

                } else if viewModel.currentGame.players.count > 3 {
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
            .font(.title)
    }

    var addButton: some View {
        Button(action: {
            withAnimation {
                viewModel.addPlayer()
                focusedPlayerIndex = viewModel.currentGame.players.count - 1
            }
        }) {
            Label("Add", systemImage: "person.fill.badge.plus")
                .accessibilityLabel("Add a player")
                .font(.system(size: 20))
                .padding(.top, 20)
        }
        .buttonStyle(PlainButtonStyle())
        
    }

    var gameControls: some View {
        HStack {
            Button("301") {
                withAnimation {
                    viewModel.currentGame.gameType = 301
                    viewModel.gameStarted = true
                    navigateToGame = true
                }
            }
            .disabled(!canStartGame)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Text("or").font(.system(size: 20))

            Button("501") {
                withAnimation {
                    viewModel.currentGame.gameType = 501
                    viewModel.gameStarted = true
                    navigateToGame = true
                }
            }
            .disabled(!canStartGame)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(.bottom, -10)
    }

    var settingsToggle: some View {
        Toggle(isOn: $viewModel.currentGame.isToggledDoubleOut) {
            Text("Double Out").font(.system(size: 18))
        }
        .padding()
        .frame(width: 200)
    }
    
    var canStartGame: Bool {
        !viewModel.currentGame.players.isEmpty && viewModel.currentGame.players.allSatisfy { !$0.name.isEmpty }
    }
    
    var playerDeleteButton: some View {
        ZStack {
            if viewModel.currentGame.players.count > 1 {
                Button(action: {
                    withAnimation {
                        viewModel.removeLastPlayer()
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                        .accessibilityLabel("Remove last player")
                }
            }
        }
    }
   
}


// ///////////////////////////
// PREVIEW //////////////////

#Preview("English") {
    FirstView()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("French") {
    FirstView()
        .environment(\.locale, Locale(identifier: "fr"))
}

#Preview("Spanish") {
    FirstView()
        .environment(\.locale, Locale(identifier: "es"))
}

#Preview("German") {
    FirstView()
        .environment(\.locale, Locale(identifier: "de"))
}

#Preview("Chinese") {
    FirstView()
        .environment(\.locale, Locale(identifier: "zh-Hans"))
}

#Preview("Japanese") {
    FirstView()
        .environment(\.locale, Locale(identifier: "ja"))
}
