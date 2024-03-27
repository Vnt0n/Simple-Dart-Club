//
//  PlayerView.swift
//  DartClub
//
//  Created by Antoine on 27/03/2024.
//

import SwiftUI
import SwiftData

struct PlayerView: View {
    @Query(sort: \Player.name) private var players: [Player]
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var score = 501
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                List {
                    ForEach(players) { player in
                        Text(player.name)
                    }
                }

                Button("Enter") {
                    let newPlayer = Player(name: name, score: score)
                    context.insert(newPlayer)
                    dismiss()
                    name = ""
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .disabled(name.isEmpty)
                
            }
        }
        
    }
}

#Preview {
    PlayerView()
}
