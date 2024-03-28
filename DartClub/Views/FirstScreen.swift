//
//  SwiftUIView.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

struct FirstScreen: View {

    @State private var name1 = ""
    @State private var score1 = 501
    
    @State private var name2 = ""
    @State private var score2 = 501
    
    @State private var name3 = ""
    @State private var score3 = 501
    
    @State private var isPlayerAdded = false
    @FocusState private var isFocusedPlayer2: Bool
    @FocusState private var isFocusedPlayer3: Bool
    
    @State private var isNameOneSubmitted = false
    @State private var isNameTwoSubmitted = false
    @State private var isNameThreeSubmitted = false
    
    @State private var isGameStarted = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
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
                        
                        TextField("", text: $name1).TextFieldStyling()
                            .onSubmit {
                                isFocusedPlayer2 = true
                                isNameOneSubmitted = true
                            }
                    } else {
                        Text(name1)
                    }
                    
                    Spacer()
                    
                    if !isNameTwoSubmitted {
                        Text("Player 2")
                        
                        TextField("", text: $name2)
                            .TextFieldStyling()
                            .focused($isFocusedPlayer2)
                            .onSubmit {
                                isNameTwoSubmitted = true
                            }
                    } else {
                        Text(name2)
                    }
                    
                    Spacer()
                    
                    if !isNameThreeSubmitted {
                        
                        if isPlayerAdded {
                            
                            Text("Player 3")
                            
                            TextField("", text: $name3)
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
                                if !name1.isEmpty && !name2.isEmpty {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isPlayerAdded = true
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                    } else {
                        Text(name3)
                    }
                    
                    Spacer()
                    
                    Button("Let's go !") {
                        if !name1.isEmpty && !name2.isEmpty {
                              isGameStarted = true
                        }
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationDestination(isPresented: $isGameStarted) {
                        GameView(name1: name1, name2: name2)
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
