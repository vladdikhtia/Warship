//
//  ContentView.swift
//  Warship
//
//  Created by Vladyslav Dikhtiaruk on 14/03/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @StateObject private var viewModel: WarshipViewModel
    
    init(){
        _viewModel = StateObject(wrappedValue: WarshipViewModel(networkService: WarshipDataService()))
    }
    @State private var isAlert = false
    @State private var isLoading = true // Local state for loading indicator
    private let dataProviderURL = URL(string: "https://russianwarship.rip/")
    @State private var gradientOffset = 0.0

    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            LinearGradient(colors: [.blue.opacity(0.8), .yellow.opacity(0.8)], startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            if isLoading{
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
            } else{
                ScrollView{
                    VStack {
                        VStack(alignment: .leading){
                            HeaderView(date: "\(viewModel.enemy?.data.date ?? "")", day: viewModel.enemy?.data.day ?? 0)
                            
                            EnemyView(name: "особового складу", amount: viewModel.enemy?.data.stats?.personnelUnits ?? 0, increaseAmount: viewModel.enemy?.data.increase?.personnelUnits ?? 0, image:"people")
                            EnemyView(name: "танків", amount: viewModel.enemy?.data.stats?.tanks ?? 0, increaseAmount: viewModel.enemy?.data.increase?.tanks ?? 0, image: "tank")
                            EnemyView(name: "ББМ", amount: viewModel.enemy?.data.stats?.armouredFightingVehicles ?? 0, increaseAmount: viewModel.enemy?.data.increase?.armouredFightingVehicles ?? 0, image: "bbm")
                            EnemyView(name: "арт. систем", amount: viewModel.enemy?.data.stats?.artillerySystems ?? 0, increaseAmount: viewModel.enemy?.data.increase?.artillerySystems ?? 0, image: "art")
                            EnemyView(name: "РСЗВ", amount: viewModel.enemy?.data.stats?.mlrs ?? 0, increaseAmount: viewModel.enemy?.data.increase?.mlrs ?? 0, image: "rszv")
                            EnemyView(name: "засобів ППО", amount: viewModel.enemy?.data.stats?.aaWarfareSystems ?? 0, increaseAmount: viewModel.enemy?.data.increase?.aaWarfareSystems ?? 0, image: "ppo")
                            EnemyView(name: "літаків", amount: viewModel.enemy?.data.stats?.planes ?? 0, increaseAmount: viewModel.enemy?.data.increase?.planes ?? 0, image: "plane")
                            EnemyView(name: "гелікоптерів", amount: viewModel.enemy?.data.stats?.helicopters ?? 0, increaseAmount: viewModel.enemy?.data.increase?.helicopters ?? 0, image: "helicopter")
                            EnemyView(name: "автотехніки та автоцистерн", amount: viewModel.enemy?.data.stats?.vehiclesFuelTanks ?? 0, increaseAmount: viewModel.enemy?.data.increase?.vehiclesFuelTanks ?? 0, image: "auto")
                            EnemyView(name: "кораблів та катерів", amount: viewModel.enemy?.data.stats?.warshipsCutters ?? 0, increaseAmount: viewModel.enemy?.data.increase?.warshipsCutters ?? 0, image: "ship")
                            EnemyView(name: "БПЛА", amount: viewModel.enemy?.data.stats?.uavSystems ?? 0, increaseAmount: viewModel.enemy?.data.increase?.uavSystems ?? 0, image: "bpla")
                            EnemyView(name: "спец. техніки", amount: viewModel.enemy?.data.stats?.specialMilitaryEquip ?? 0, increaseAmount: viewModel.enemy?.data.increase?.specialMilitaryEquip ?? 0, image: "special")
                            EnemyView(name: "підводних човнів", amount: viewModel.enemy?.data.stats?.submarines ?? 0, increaseAmount: viewModel.enemy?.data.increase?.submarines ?? 0, image: "submarine")
                            EnemyView(name: "крилатих ракет", amount: viewModel.enemy?.data.stats?.cruiseMissiles ?? 0, increaseAmount: viewModel.enemy?.data.increase?.cruiseMissiles ?? 0, image: "rocket")
                        }
                        
                        
                        VStack(alignment: .center, spacing: 20){
                            Text("Бажаєш збільшити стату?")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .frame(alignment: .leading)
                            
                            Button {
                                openURL(URL(string: "https://savelife.in.ua/en/donate-en/")!)
                            } label: {
                                Label("Повернись живим", systemImage: "heart.square")
                                    .padding()
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.semibold)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .green, .cyan, .yellow]),
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                        .hueRotation(.degrees(gradientOffset))
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .onAppear(perform: {
                                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                    gradientOffset = 360
                                }
                            })
                            
                            
                            
                            Link(destination:dataProviderURL!, label: {
                                Text("Data provided by 'russianwarship.rip'")
                                    .underline()
                            })
                            
                        }
                        .padding(.vertical, 20)
                    }
                    .foregroundStyle(.black)
                    
                }
                .refreshable {
                    await refreshData()
                    print("refreshed")
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: viewModel.errorMessage, showError)
        .alert("Oops!", isPresented: $isAlert) {
            Button("OK") { }
        } message: {
            Text("\(viewModel.errorMessage ?? " ")")
                .font(.headline)
                .fontWeight(.semibold)
        }
        .onAppear {
            loadData()
        }
    }
    
    private func loadData() {
        isLoading = true
        Task {
            await refreshData()
            isLoading = false
        }
    }
    private func refreshData() async {
        await viewModel.fetchEnemyAsync()
    }
    
    func showError() {
        if viewModel.errorMessage != nil {
            isAlert = true
        }
    }
}

#Preview {
    ContentView()
}
