//
//  CreatingWordView.swift
//  Course work
//
//  Created by admin on 7.11.23.
//

import SwiftUI

struct CreatingWordView: View {
    
    //связываю для анимерованной прокрутки
    @Binding var wordFormNow: WordFormsEnum
    @ObservedObject var viewModel: CreateScreenViewModel
    
    @State private var acceptAlert = false
    @State private var errorAlert = false
    
    var body: some View {
        VStack {
            HStack {
                //ридер для прокрутке к выбранной словоформе
                ScrollViewReader {value in
                    //прокрутка будет горизантальной
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(WordFormsEnum.allCases, id: \.self) {wordForm in
                                Text(viewModel.word[wordForm] ?? "...")
                                    .padding(.horizontal,10)
                                    .foregroundColor(wordForm == wordFormNow ? .black : .gray)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .id(wordForm)
                                    .padding(.vertical,7)
                            }
                        }
                    }
                    //сдвинул вправо для симетричного расположения
                    .offset(x:20)
                    
                    .frame(width: 200)
                    .onChange(of: wordFormNow) {_ ,newValue in
                        //при переключение на новый
                        //раздел TabView запускает прокрутку
                        withAnimation(.linear) {
                            value.scrollTo(newValue)
                        }
                    }
                    
                    
                }
                .padding(.trailing,17)
                //разделитеть между словоформами
                //и кнопками взаимодеймтвия
                Rectangle()
                    .frame(width: 2,height: 20)
                
                //удаляет все установленные
                //словоформы слова
                Button {
                    viewModel.word.clear()
                    viewModel.word = viewModel.word
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.gray)
                        .font(.title)
                        .fontWeight(.medium)
                }
                
                Button  {
                    //если все словоформы
                    //имеют nil - выдать ошибку
                    if viewModel.word.getFullWord() == nil {
                        errorAlert = true
                    } else {
                        //иначе выдать уведомление подтверждения
                        acceptAlert = true
                    }
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .fontWeight(.medium)
                }
                .padding(.leading,10)
                
                //алерт пустого слова
                .alert(
                    Text("Вы не можете создать пустое слово!"),
                    isPresented: $errorAlert,
                    actions: {
                        Button("Я все понял") {}
                    })
                
                //алерт успешно созданного слова
                .alert(
                    Text("Поздравяю!"),
                    isPresented: $acceptAlert,
                    actions: {
                        Button(role: .cancel) {
                            //не создавать слово
                        } label: {
                            Text("Я передумал")
                        }
                        Button {
                            // добавить слово в колекцию
                            viewModel.createWord()
                            
                            //возвращаю пользователя
                            //обратно к префиксам
                            withAnimation(.linear(duration: 0.3)) {
                                wordFormNow = .pref
                            }
                        } label: {
                            Text("Продолжить")
                        }
                    },
                    message: {
                        Text("Ты создал слово: \(viewModel.word.getFullWord() ?? "")")
                    })
            }
            Divider()
        }
    }
    
    private func createAlert() {}
}

fileprivate struct Test: View {
    @State private var wordFormNow = WordFormsEnum.pref
    @ObservedObject var viewModel = CreateScreenViewModel(provider: .shared)
    var body: some View {
        CreatingWordView(wordFormNow: $wordFormNow,viewModel: viewModel)
        
    }
}

struct CreatingWordView_Previews: PreviewProvider {
    static var previews: some View {
        Test()

    }
}
