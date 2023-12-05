//
//  ContentView.swift
//  Course work
//
//  Created by admin on 3.11.23.
//

import SwiftUI

struct MainScreen: View {
    var provider = Provider.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                //Лэйбл приложения
                HStack {
                    Text("Word Composition")
                        .font(.title)
                        .fontWeight(.bold)
                    Image(systemName: "w.circle")
                        .foregroundColor(.blue)
                }
                Capsule()
                    .frame(width: 260,height: 3)
                    .padding(.top,-15)
                
                
                
                NavigationLink {
                    WordFormsScreen(provider: provider)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Список словоформ")
                        .buttonModifier(.title2)
                        .fontWeight(.semibold)
                }
                
                NavigationLink {
                    WordsScreen(provider: Provider.shared)
                        .toolbar(.hidden)
                } label: {
                    Text("Список слов")
                        .buttonModifier(.title2)
                        .fontWeight(.semibold)
                }
                
                
                NavigationLink {
                    CreateScreenView(viewModel: CreateScreenViewModel(provider: provider))
                        .toolbar(.hidden)
                } label: {
                    Text("Создать слово")
                        .buttonModifier(.title)
                        .bold()
                        .background(Capsule().foregroundStyle(.gray.opacity(0.5)))
                }
                .padding(.top,40)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .environment(\.managedObjectContext, Provider.shared.viewContext)
    }
}
