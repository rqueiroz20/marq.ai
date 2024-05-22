//
//  LandingPageView.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 5/13/24.
//

import SwiftUI

struct LandingPageView: View {
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
        }
    }

}

#Preview {
    LandingPageView()
}
