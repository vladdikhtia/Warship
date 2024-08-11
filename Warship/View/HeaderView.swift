//
//  HeaderView.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 16/03/2024.
//

import SwiftUI

struct HeaderView: View {
    private let url = URL(string: "https://www.mil.gov.ua/")
    let date: String
    let day: Int
    
    var body: some View {
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
            Text("Станом на: \(formattedDate(date:date))")
                .fontWeight(.semibold)
                .padding(.vertical, 8)
            
            Text("\(day)-й день війни")
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .underline(pattern: .solid)
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

//#Preview {
//    HeaderView(date: <#String#>, day: <#Int#>)
//}
