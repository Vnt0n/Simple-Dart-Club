//
//  FirstView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

class DeviceOrientationManager: ObservableObject {
    static let shared = DeviceOrientationManager()
    @Published var isLandscape: Bool = false
    @Published var isFlat: Bool = false


    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    @objc func orientationChanged() {
        DispatchQueue.main.async {
            self.isLandscape = UIDevice.current.orientation.isLandscape
            self.isFlat = UIDevice.current.orientation.isFlat

        }
    }
}

struct FirstView: View {
    
    @ObservedObject private var orientationDetected = DeviceOrientationManager.shared

    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    @State private var navigateToGame = false
    @StateObject var viewModel = GameViewModel(gameType: 0)
    @FocusState private var focusedPlayerIndex: Int?
    @State private var showSettingsView = false
    @State private var isDartClubVisible = true

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black.ignoresSafeArea(.all)

                VStack {

                    Spacer()
                    
                    if UIDevice.current.userInterfaceIdiom == .pad && orientationDetected.isLandscape || UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape {
                        
                        HStack {
                                                        
                            dartClubText
                                .frame(maxWidth: 650)
                            
                            VStack {
                                
                                Spacer()
                                
                                playerFields
                                                                
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
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                Spacer()
                                
                                gameControls
                                
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
                            
                            Spacer()

                        }
                        
                    } else {
                        
                        VStack {
                                
                            Spacer()
                                
                            if isDartClubVisible {

                                dartClubText

                            }
                                
                            playerFields
                                
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
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            Spacer()
                            
                            gameControls
                            
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
                    }
                    
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
        .preferredColorScheme(.dark)
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
                .frame(maxWidth: .infinity)
                .padding([.trailing], 40)
            
            Text("Club   ")
                .font(Font
                    .custom("FightThis", size: UIDevice.current.userInterfaceIdiom == .pad ? 145 : 84))
                .shadow(color: Color.red, radius: 15)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .rotationEffect(Angle(degrees: 347))
                .frame(maxWidth: .infinity)
                .padding([.trailing], 40)
                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 0 : -80)

            
        }
        .transition(.opacity)
    }
    
    var playerFields: some View {
        ForEach(0..<viewModel.currentGame.players.count, id: \.self) { index in
            TextField("Player \(index + 1)", text: $viewModel.currentGame.players[index].name)
                .padding(.horizontal, 50)
                .textFieldStyle(.roundedBorder)
                .frame(width: 350)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .foregroundColor(.primary)
                .focused($focusedPlayerIndex, equals: index)
                .onChange(of: focusedPlayerIndex) {
                    if focusedPlayerIndex != nil {
                        withAnimation(.easeInOut) {
                            isDartClubVisible = false
                        }
                    } else {
                        withAnimation(.easeInOut) {
                            isDartClubVisible = true
                        }
                    }
                }
            }
            .font(.title)
    }
    
    var gameControls: some View {
        HStack {
            Button("301") {
                print("--------------------------------------------")
                print("BUTTON 301")
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
                print("--------------------------------------------")
                print("BUTTON 501")
                viewModel.currentGame.gameType = 501
                viewModel.gameStarted = true
                navigateToGame = true
            }
            .disabled(!canStartGame)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
//////////////////////////////////////////////////////////////////// SETTINGSVIEW /////////////////////////////////////////////////////////////////
            
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

//        Button(action: {
//
//            print("--------------------------------------------")
//            print("--------------------------------------------")
//            print("DEBUG")
//            print("--------------------------------------------")
//            print("--------------------------------------------")
//            print("DOUBLE OUT: \(viewModel.currentGame.isToggledDoubleOut)")
//            print(" ")
//            print(" ")
//
//        }) {
//            Image(systemName: "ladybug.circle")
//                .accessibilityLabel("Undo")
//                .font(.system(size: 25))
//        }
//        .buttonStyle(PlainButtonStyle())

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
        }

    }
    
    var canStartGame: Bool {
        !viewModel.currentGame.players.isEmpty && viewModel.currentGame.players.allSatisfy { !$0.name.isEmpty }
    }

}


// ///////////////////////////
// PREVIEW //////////////////

#Preview("English") {
    FirstView()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Français") {
    FirstView()
        .environment(\.locale, Locale(identifier: "fr"))
}
