//
//  GameViewV2.swift
//  DartClub
//
//  Created by Antoine on 21/04/2024.
//

import SwiftUI

struct GameViewV2: View {
    
    var isThreeHundredOne: Bool
    var isFiveHundredOne: Bool
    
    var namePlayer1: String
    var namePlayer2: String
    var namePlayer3: String
        
    var body: some View {
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        
    }
}


struct GameViewV2_Previews: PreviewProvider {
    static var previews: some View {
        GameViewV2(isThreeHundredOne: true, isFiveHundredOne: false, namePlayer1: "Player 1", namePlayer2: "Player 2", namePlayer3: "Player 3")
    }
}
