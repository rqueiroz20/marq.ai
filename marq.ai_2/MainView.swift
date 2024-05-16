//
//  MainView.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 4/29/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("MARQ.ai")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Welcome to MARQ.ai! If you are about to go out for an extended period of time, press the button below to ensure your safety.")
                    .font(.system(size: 20))
                    .italic()
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink(destination: LandingPageView()) {
                        Text("I'm Going Out!")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
