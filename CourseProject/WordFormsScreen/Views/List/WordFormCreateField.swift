//
//  WordFormCreateField.swift
//  Course
//
//  Created by admin on 22.11.23.
//

import SwiftUI

struct WordFormCreateField: View {
    @ObservedObject var viewModel: CreateFieldViewModel
    
    @State private var createText = ""
    
    @FocusState private var nameIsFocused
    @State private var nameIsFocusedAnimated = false
    var body: some View {
        HStack {
            TextField("Добавить", text: $createText)
                .padding(5)
            
                .font(.title2)
                .overlay(
                    Capsule()
                        .stroke(lineWidth: 1)
                )
                .focused($nameIsFocused)
                .onChange(of: nameIsFocused) { _, newValue in
                    withAnimation(.easeOut) {
                        nameIsFocusedAnimated = newValue
                    }
                    if !newValue && !createText.isEmpty {
                        self.create()
                        createText = ""
                    }
                }
            
            Group {
                Button {
                    //someDestructive
                    createText = ""
                    nameIsFocused = false
                } label: {
                    Image(systemName: "plus")
                        .offset(x:nameIsFocusedAnimated ? 0 : -210)
                        .foregroundStyle(nameIsFocusedAnimated ? .red : .gray)
                        .opacity(nameIsFocusedAnimated ? 1 : 0.4)
                        .rotationEffect(.degrees(nameIsFocusedAnimated ? -135 : 0))
                    
                    
                }
                .disabled(!nameIsFocused)
                
                Button {
                    //someCreatings
                    if createText.isEmpty {
                        nameIsFocused = false
                    } else {
                        self.create()
                        createText = ""
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                }
                .opacity(nameIsFocusedAnimated ? 1 : 0)
                .animation(.easeInOut(duration: 0.1), value: nameIsFocusedAnimated)
            }
            .padding(.horizontal,nameIsFocusedAnimated ? 0 : -60)
            .font(.title)
        }
        .padding(.leading, 10)
    }
    
    private func create() {
        withAnimation(.easeInOut(duration: 0.1)) {
            viewModel.createWordForm(from: createText)
        }
    }
}

#Preview {
    WordFormCreateField(viewModel: CreateFieldViewModel.init(context: Provider.shared.viewContext, wordFormType: .pref))
}
