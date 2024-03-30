//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstScreen: View {

    @State private var namePlayer1 = ""
    @State private var namePlayer2 = ""
    @State private var namePlayer3 = ""
    
    @State private var isPlayerAdded = false
    @FocusState private var isFocusedPlayer2: Bool
    @FocusState private var isFocusedPlayer3: Bool
    
    @State private var isNameOneSubmitted = false
    @State private var isNameTwoSubmitted = false
    @State private var isNameThreeSubmitted = false
    
    @FocusState private var isFocused: Bool
    
    @State private var isGameStarted = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.gray)
                    .ignoresSafeArea(.all)
                VStack {
                    
                    Spacer()
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280)
                    
                    Spacer()
                    
                    if !isNameOneSubmitted {
                        Text("Player 1")
                        
                        TextField("", text: $namePlayer1).TextFieldStyling()
                            .onSubmit {
                                isFocusedPlayer2 = true
                                isNameOneSubmitted = true
                            }
                            .focused($isFocused)
                            .onAppear {
                                self.isFocused = true
                            }
                    } else {
                        Text(namePlayer1)
                    }
                    
                    Spacer()
                    
                    if !isNameTwoSubmitted {
                        Text("Player 2")
                        
                        TextField("", text: $namePlayer2)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer2)
                            .onSubmit {
                                isNameTwoSubmitted = true
                            }
                    } else {
                        Text(namePlayer2)
                    }
                    
                    Spacer()
                    
                    if !isNameThreeSubmitted {
                        
                        if isPlayerAdded {
                            
                            Text("Player 3")
                            
                            TextField("", text: $namePlayer3)
                                .TextFieldStyling()
                                .focused($isFocusedPlayer3)
                                .onAppear {
                                    isFocusedPlayer3 = true
                                }
                                .onSubmit {
                                    isNameThreeSubmitted = true
                                }
                            
                            Spacer()
                            
                        } else {
                            Button("+ Add a player") {
                                if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isPlayerAdded = true
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                    } else {
                        Text(namePlayer3)
                    }
                    
                    Spacer()
                    
                    Button("Let's go !") {
                        if !namePlayer1.isEmpty && !namePlayer2.isEmpty {
                              isGameStarted = true
                        }
                    }
                    .disabled(namePlayer1.isEmpty && namePlayer2.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    .navigationDestination(isPresented: $isGameStarted) {
                        GameView(namePlayer1: namePlayer1, namePlayer2: namePlayer2, namePlayer3: namePlayer3)
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

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
