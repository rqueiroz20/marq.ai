//
//  Results1View.swift
//  marq.ai_2
//
//  Created by Rafael Queiroz on 4/29/24.
//

import SwiftUI

struct Results1View: View {
    var body: some View {
        VStack {
            Text("Sobriety Test")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Results")
                .font(.subheadline)
                .fontWeight(.medium)
            Text("Recommendation: Sober")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .padding()
            Spacer()
            
            Text("The results of your test find that you are in a sober state and are capable of performing most activities that require undivided attention. Above are some points that you should consider before performing said activities.")
                .multilineTextAlignment(.center)
                .italic()
                .font(.system(size: 20))
            
            NavigationLink(destination: MainView()) {
                Text("Back to Main Menu")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    Results1View()
}
