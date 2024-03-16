//
//  EnemyView.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 16/03/2024.
//

import SwiftUI

struct EnemyView: View {
    var name: String
    var amount: Int
    var increaseAmount: Int
    var image: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 40) {
            //            Rectangle()
            //                .frame(width: 100, height: 75)
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 75)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(amount)")
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("(+\(increaseAmount))")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                Text("\(name)")
                    .font(.subheadline)
            }
        }
        Divider()
    }
}

#Preview {
    EnemyView(name: "Особового складу", amount: 312312, increaseAmount: 321, image: " ")
}
