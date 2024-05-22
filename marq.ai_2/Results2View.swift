//
//  Results2View.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 4/29/24.
//

import SwiftUI

struct Results2View: View {
    var body: some View {
        VStack {
            Text("Sobriety Test")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Results")
                .font(.subheadline)
                .fontWeight(.medium)
            Text("Test Results: Not Sober")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .padding()
            Spacer()
            
            Text("The results of your test find that you are NOT in a sober state and are NOT capable of performing most activities that require undivided attention.")
                .padding()
                .multilineTextAlignment(.center)
                .italic()
                .font(.system(size: 20))
            
            NavigationLink(destination: MainView()) {
                Text("Back to Main Menu")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    Results2View()
}
