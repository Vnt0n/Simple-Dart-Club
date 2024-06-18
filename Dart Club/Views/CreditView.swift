//
//  CreditView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct CreditView: View {
        
    var body: some View {

        ZStack {
            VStack {

                ScrollView {
                    
                    Text("Dart   ")
                        .font(Font.custom("FightThis", size: 40))
                        .shadow(color: Color.red, radius: 15)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .rotationEffect(Angle(degrees: 347))
                        .frame(maxWidth: .infinity)
                        .padding([.trailing], 40)
                        .padding(.top, 30)
                    
                    Text("Club   ")
                        .font(Font.custom("FightThis", size: 40))
                        .shadow(color: Color.red, radius: 15)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .rotationEffect(Angle(degrees: 347))
                        .frame(maxWidth: .infinity)
                        .padding([.trailing], 40)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Divider()

                        Text("Dart Game Rules")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding()
                        
                        Group {
                            Text("1. Required Equipment:")
                                .font(.headline)
                                .padding()
                            
                            Text("-     A dart consists of a metallic tip, a barrel, and can include up to five parts such as flights and protectors.")
                            Text("-     The dartboard is divided into numbered segments with double and triple zones that allow for higher scoring.")
                            Text("-     The correct dartboard height is 5 feet 8 inches (173 cm) from the Bullseye to the floor.")
                            Text("-     The distance from the throw line to the dartboard is 8 feet (237 cm).")
                        }

                        Group {
                            Text("2. How to Play:")
                                .font(.headline)
                                .padding()

                            Text("-     Darts must be thrown one at a time, deliberately and towards the target. Each round consists of three dart throws.")
                            Text("-     Each leg starts without any special conditions for scoring (straight in).")
                            Text("-     ONLY IF THE \"DOUBLE OUT\" OPTION IS ENABLED: Each leg ends by doubling, meaning the final throw must land in a double zone or the Bullseye.")
                            Text("-    The center of the dartboard (Bullseye) counts for 50 points and is also considered a double 25.")
                        }

                        Group {
                            Text("3. Scoring:")
                                .font(.headline)
                                .padding()

                            Text("-     Points are subtracted from an initial total (301 or 501) until exactly zero is reached. Scores are recorded based on the section of the dartboard where the dart lands (single, double, or triple).")
                            Text("-     ONLY IF THE \"DOUBLE OUT\" OPTION IS ENABLED: To win a leg, the player must finish by reducing their score to exactly zero by hitting a double.")
                            Text("-     If a dart falls or bounces out of the dartboard, it does not count. Furthermore, finishing with a score higher than needed is an error that cancels the throw.")
                            Text("-     If a player exceeds the needed score, their turn is invalid (bust), and they must restart from the score they had before that throw on their next turn.")
                            Text("-     ONLY IF THE \"DOUBLE OUT\" OPTION IS ENABLED: If a player reaches a score of 1, or doesn't finish on a double, their turn is invalid (bust), and they must restart from the score they had before that throw on their next turn.")
                        }

                        Group {
                            Text("4. Additional Rules:")
                                .font(.headline)
                                .padding()

                            Text("-     Touching or manipulating darts in the dartboard before completing the turn is prohibited.")
                            Text("-     Scoring errors must be corrected before the next player's throw.")
                            Text("-     Having fun is mandatory, failure to comply will result in exclusion in the kitchen with a bowl on your head.")
                        }
                        
                        Group {
                            HStack {
                                Spacer()
                                Text("These are exact official rules from the World Darts Federation (if 501 and \"Double Out\" enabled)")
                                    .italic()
                                    .font(.system(size: 15))
                                Spacer()
                            }
                        }
                        .padding()
                        
                        VStack {
                            HStack {
                                Spacer()
                                Text("This app use ConfettiSwiftUI")
                                    .font(
                                        .system(size: 10)
                                    )
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Copyright (c) 2020 Simon Bachmann")
                                    .font(
                                        .system(size: 10)
                                    )
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                Divider()
                
                Text("An app by")
                    .font(.system(size: 15).weight(.bold))
                    .padding(.top, 10)
                               
                Link("vnton.xyz", destination: URL(string: "https://vnton.xyz")!)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.bottom, 1)
                
                Text("V 1.0 | © 2024 A. Chosson")
                    .font(
                        .system(size: 10)
                    )
                
                Spacer()
                Spacer()
                Spacer()

            }
            .frame(maxWidth: 560)
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview("English") {
    CreditView()
        .environment(\.locale, Locale(identifier: "en"))
}
#Preview("French") {
    CreditView()
        .environment(\.locale, Locale(identifier: "fr"))
}

#Preview("Spanish") {
    CreditView()
        .environment(\.locale, Locale(identifier: "es"))
}

#Preview("German") {
    CreditView()
        .environment(\.locale, Locale(identifier: "de"))
}

#Preview("Chinese") {
    CreditView()
        .environment(\.locale, Locale(identifier: "zh-Hans"))
}

#Preview("Japanese") {
    CreditView()
        .environment(\.locale, Locale(identifier: "ja"))
}
