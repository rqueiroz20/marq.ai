//
//  LandingPageView.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 5/13/24.
//

import SwiftUI

struct LandingPageView: View {
    @State var countdownTimer = 7200
    @State var timerRunning = true
    @State var text = "< 2 hours"
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Enjoy!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Text("Ready to take a sobriety test?")
                .font(.system(size: 20))
                .italic()
                .multilineTextAlignment(.center)
            Spacer()
            NavigationLink(destination: SobrietyTest1()) {
                Text("Take Sobriety Test")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
               
            }
            Text("Time to Unlock: \(text)")
                .onReceive(timer) { _ in
                    if countdownTimer > 0 && timerRunning {
                        countdownTimer -= 1
                        if countdownTimer < 3600 {
                            text = "< 1 hour"
                        } else if countdownTimer < 1800 {
                            text = "< 30 minutes"
                        } else if countdownTimer < 900 {
                            text = "< 15 minutes"
                        }
                    } else {
                        timerRunning = false
                    }
                }
                .padding()
        }
    }

}

#Preview {
    LandingPageView()
}
