//
//  LandingPageView.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 5/13/24.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
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
                Text("Take Sobriety Test")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Text("Time to Unlock: 1:24:43")
                    .padding()
            }
        }
    }
}

#Preview {
    LandingPageView()
}
