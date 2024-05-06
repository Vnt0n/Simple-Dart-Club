//
//  CreditView.swift
//  Dart Club
//
//  Created by Antoine on 02/05/2024.
//

import SwiftUI

struct CreditView: View {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {

        ZStack {
            VStack {
                
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

                ScrollView {
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
                                    Text("-     The correct dartboard height is 5 feet 8 inches (173 cm) from the bullseye to the floor.")
                                    Text("-     The distance from the throw line to the dartboard is 8 feet (237 cm).")
                                }

                                Group {
                                    Text("2. How to Play:")
                                        .font(.headline)
                                        .padding()

                                    Text("-     Darts must be thrown one at a time, deliberately and towards the target. Each round consists of three dart throws.")
                                    Text("-     Each leg starts without any special conditions for scoring (straight in).")
                                    Text("-     ONLY IF THE DOUBLE OUT OPTION IS ENABLED: Each leg ends by doubling, meaning the final throw must land in a double zone or the bullseye.")
                                    Text("-    The center of the dartboard (Bullseye) counts for 50 points and is also considered a double 25.")
                                }

                                Group {
                                    Text("3. Scoring:")
                                        .font(.headline)
                                        .padding()

                                    Text("-     Points are subtracted from an initial total (301 or 501) until exactly zero is reached. Scores are recorded based on the section of the dartboard where the dart lands (single, double, or triple).")
                                    Text("-     ONLY IF THE DOUBLE OUT OPTION IS ENABLED: To win a leg, the player must finish by reducing their score to exactly zero by hitting a double.")
                                    Text("-     If a dart falls or bounces out of the dartboard, it does not count. Furthermore, finishing with a score that does not allow for a double finish or a score higher than needed is an error that cancels the throw.")
                                    Text("-     If a player exceeds the needed score, their turn is invalid (bust), and they must restart from the score they had before that throw on their next turn.")
                                    Text("-     ONLY IF THE DOUBLE OUT OPTION IS ENABLED: If a player reaches a score of 1, or doesn't finish on a double, their turn is invalid (bust), and they must restart from the score they had before that throw on their next turn.")
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
                                    Text("These are exact official rules from the World Darts Federation (if 501 and Double Out enabled)")
                                        .italic()
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 15))
                                }
                                .padding()
                            }
                            .padding()
                        }
                
                Spacer()
                Divider()
                
                Text("An app provided by")
                    .font(
                        .system(size: 15)
                        .weight(.bold))
                    .padding(.top, 10)
                Spacer()
                Link("github.com/Vnt0n", destination: URL(string: "https://github.com/Vnt0n")!)
                    .font(.system(size: 15))
                    .bold()
                
                Spacer()

                Text("Beta V.3.0")
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
#Preview("Français") {
    CreditView()
        .environment(\.locale, Locale(identifier: "fr"))
}
