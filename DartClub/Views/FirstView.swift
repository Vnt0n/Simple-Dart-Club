//
//  FirstView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstView: View {
    
    @State private var isGameStarted = false
    @State private var isPlayerAdded = false
    @State private var isNameOneSubmitted = false
    @State private var isNameTwoSubmitted = false
    @State private var isNameThreeSubmitted = false
    
    @FocusState private var isFocusedPlayer2: Bool
    @FocusState private var isFocusedPlayer3: Bool
    
    @State private var namePlayer1 = ""
    @State private var namePlayer2 = ""
    @State private var namePlayer3 = ""
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea(.all)
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
                    
                    if !isNameOneSubmitted {
                        
                        TextField("Player 1", text: $namePlayer1)
                            .TextFieldStyling()
                            .onSubmit {
                                isFocusedPlayer2 = true
                                isNameOneSubmitted = true
                            }
                            .font(.title)
                    } else {
                        Text(namePlayer1)
                    }
                    
                    Spacer()
                    
                    if !isNameTwoSubmitted {
                        
                        TextField("Player 2", text: $namePlayer2)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer2)
                            .onSubmit {
                                isNameTwoSubmitted = true
                            }
                            .font(.title)
                    } else {
                        Text(namePlayer2)
                    }
                    
                    Spacer()
                    
                    if !isNameThreeSubmitted {
                        
                        if isPlayerAdded {
                            
                            TextField("Player 3", text: $namePlayer3)
                                .TextFieldStyling()
                                .focused($isFocusedPlayer3)
                                .onAppear {
                                    isFocusedPlayer3 = true
                                }
                                .onSubmit {
                                    isNameThreeSubmitted = true
                                }
                                .font(.title)
                            
                            Spacer()
                            
                        } else {
                            
                            Button(action: {
                                if !namePlayer1.isEmpty {
                                        isPlayerAdded = true
                                    }
                            }) {
                                if !namePlayer1.isEmpty {
                                    Label("Add a player", systemImage: "person.fill.badge.plus")
                                        .accessibilityLabel("Add a player")
                                        .font(.system(size: 20))
                                        .padding(.top, 20)
                                } else {
                                    Label("Add a player", systemImage: "person.fill.badge.plus")
                                        .accessibilityLabel("Add a player")
                                        .font(.system(size: 20))
                                        .foregroundColor(.gray)
                                        .padding(.top, 20)
                                }
                            }
                        }

                        Spacer()
                        
                    } else {
                        Text(namePlayer3)
                    }
                    
                    Spacer()
                    HStack {
                        Button("301") {
                            if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                isGameStarted = true
                            }
                        }
                        .disabled(namePlayer1.isEmpty || namePlayer2.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 15)
                        .navigationDestination(isPresented: $isGameStarted) {
                            GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
                        }
                        
                        Spacer()
                        
                        Text("or")
                            .font(.system(size: 20))
                            .padding(.bottom, 15)

                        Spacer()
                        
                        Button("501") {
                            if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                isGameStarted = true
                            }
                        }
                        .disabled(namePlayer1.isEmpty || namePlayer2.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 15)
                        .navigationDestination(isPresented: $isGameStarted) {
                            GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .shadow(radius: 10)
                .navigationBarBackButtonHidden(true)
                .frame(width: 200)
                
            }
            
        }
    }
}


// PREVIEWS ///////////////////

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
