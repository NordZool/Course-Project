//
//  CreateScreenView.swift
//  Course work
//
//  Created by admin on 4.11.23.
//

import SwiftUI
import CoreData

struct CreateScreenView: View {
    //используется для получения словоформ в CreateWordFormList
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    //viewModel (через информацию из View составит нужную модель данных)
    @ObservedObject var viewModel: CreateScreenViewModel
    
    //изначально будет открыт раздел приставок
    @State private var wordFormNow = WordFormsEnum.pref
    
    var body: some View {
        ZStack(alignment:.top) {
            //связываем wordFormNow с табвью
            TabView(selection: $wordFormNow) {
                ForEach(WordFormsEnum.allCases, id: \.self) {wordForm in
                    CreateWordFormList(
                        typeWordForm: wordForm,
                        wordFormNow: $wordFormNow,
                        word: $viewModel.word,
                        context: managedObjectContext
                    )
                    //благодаря тэгам TabView понимает на какое вью перейти
                    .tag(wordForm)
                    //чтобы лист не упирался в CreatingWordView
                    .padding(.top,43)
                    //чтобы лист не упирался в tabview
                    .padding(.bottom,28)
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            CustomTabView(wordFormNow: $wordFormNow)
            CreatingWordView(wordFormNow: $wordFormNow,viewModel: viewModel)
            //чтобы не заграждало BackButton
                .padding(.trailing,-50)
            
            BackButton()
            
        }
    }
}


#Preview
{
    CreateScreenView(viewModel: .init(provider: .shared))
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
