//
//  ContentView.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://www.mil.gov.ua/")
    
    @StateObject var viewModel = WarshipViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue.opacity(0.8), .yellow.opacity(0.8)], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack{
                    VStack(spacing: 10) {
                        Text("Генеральний штаб ЗС України інформує")
                            .font(.footnote)
                        Text("Загальні бойові втрати \nросійського окупанта")
                            .font(.title2).bold()
                            .fontDesign(.rounded)
                    }
                    .foregroundStyle(.primary)
                    Spacer()
                    VStack{
                        Image("MOU")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Link("mil.gov.ua", destination: url!)
                            .foregroundStyle(.blue)
                    }
                }
                
                
                Text("Станом на: \(formattedDate(date:viewModel.enemy?.data.date ?? " "))")
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                
                Text("\(viewModel.enemy?.data.day ?? 0)-й день війни")
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .underline(pattern: .solid)
                    
//                List(viewModel.enemy?.data.stats) { s in
//                    Text("\(enemy.data.stats)")
//                }
                Text("Stats: \(viewModel.enemy?.data.stats.tanks ?? 0)")
                
            }
            .padding()
        }
    }
    
    func formattedDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Set your desired date format here
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd MMMM yyyy" // Set your desired output format here
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}

#Preview {
    ContentView()
}
