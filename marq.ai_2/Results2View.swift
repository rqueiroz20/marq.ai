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
            Text("Recommendation: Not Sober")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .padding()
            Spacer()
            
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
