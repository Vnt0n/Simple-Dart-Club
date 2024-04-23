//
//  FirstViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct FirstViewV2: View {
    
    @State private var isGameStarted = false
    
    @State private var isPlayerThreeAdded = false
    @State private var isPlayerFourAdded = false
    
    @State private var isNameOneSubmitted = false
    @State private var isNameTwoSubmitted = false
    @State private var isNameThreeSubmitted = false
    @State private var isNameFourSubmitted = false
        
    @FocusState private var isFocusedPlayer2: Bool
    @FocusState private var isFocusedPlayer3: Bool
    @FocusState private var isFocusedPlayer4: Bool
 
    @State private var namePlayer1 = ""
    @State private var namePlayer2 = ""
    @State private var namePlayer3 = ""
    @State private var namePlayer4 = ""
    
    @State private var isThreeHundredOne = false
    @State private var isFiveHundredOne = false
    
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
                                            
                        TextField("Player 1", text: $namePlayer1)
                            .TextFieldStyling()
                            .onSubmit {
                                isNameOneSubmitted = true
                                isFocusedPlayer2 = true
                            }
                            .font(.title)
                    
                    Spacer()
                                            
                        TextField("Player 2", text: $namePlayer2)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer2)
                            .onSubmit {
                                isNameTwoSubmitted = true
                                isFocusedPlayer3 = true
                            }
                            .font(.title)
                                      
                    Spacer()
                                           
                    if isPlayerThreeAdded {
                        
                        TextField("Player 3", text: $namePlayer3)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer3)
                            .onSubmit {
                                isNameThreeSubmitted = true
                                isFocusedPlayer4 = true
                            }
                            .font(.title)
                        
                        Spacer()
                        
                    } else {
                        
                        Button(action: {
                            if !namePlayer1.isEmpty {
                                isPlayerThreeAdded = true
                                isFocusedPlayer3 = true
                            }
                        }) {
                            if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                Label("Add a 3rd player", systemImage: "person.fill.badge.plus")
                                    .accessibilityLabel("Add a player")
                                    .font(.system(size: 20))
                                    .padding(.top, 20)
                            } else {
                                Label("Add a 3rd player", systemImage: "person.fill.badge.plus")
                                    .accessibilityLabel("Add a player")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                            }
                        }
                        
                        Spacer()
                        
                    }
                        
                    if isPlayerFourAdded {
                        
                        TextField("Player 4", text: $namePlayer4)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer4)
                            .onSubmit {
                                isNameFourSubmitted = true
                            }
                            .font(.title)
                        
                        Spacer()
                                                
                    } else {
                                                
                        Button(action: {
                            if !namePlayer3.isEmpty {
                                isPlayerFourAdded = true
                                isFocusedPlayer4 = true
                            }
                        }) {
                            if !namePlayer3.isEmpty {
                                Label("Add a 4th player", systemImage: "person.fill.badge.plus")
                                    .accessibilityLabel("Add a player")
                                    .font(.system(size: 20))
                                    .padding(.top, 20)
                            } else {
                                Label("Add a 4th player", systemImage: "person.fill.badge.plus")
                                    .accessibilityLabel("Add a player")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button("301") {
                            if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                isGameStarted = true
                                isThreeHundredOne = true
                            }
                        }
                        .disabled(namePlayer1.isEmpty || namePlayer2.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 15)
                        .navigationDestination(isPresented: $isGameStarted) {
                            GameView(isThreeHundredOne: isThreeHundredOne, isFiveHundredOne: isFiveHundredOne, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
                        }
                                                
                        Text("or")
                            .font(.system(size: 20))
                            .padding(.bottom, 15)
                        
                        Button("501") {
                            if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                isGameStarted = true
                                isFiveHundredOne = true
                            }
                        }
                        .disabled(namePlayer1.isEmpty || namePlayer2.isEmpty)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom, 15)
                        .navigationDestination(isPresented: $isGameStarted) {
                            GameView(isThreeHundredOne: isThreeHundredOne, isFiveHundredOne: isFiveHundredOne, namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
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

#Preview {
    FirstViewV2()
}
