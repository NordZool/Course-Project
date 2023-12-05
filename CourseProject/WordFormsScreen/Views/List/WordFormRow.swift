//
//  WordFormRow.swift
//  Course
//
//  Created by admin on 22.11.23.
//

import SwiftUI
import CoreData

struct WordFormRow: View {
    //only for save changes
    var context: NSManagedObjectContext
    //only for correct text
    let wordFormType: WordFormsEnum
    
    @ObservedObject var form: WordForm
    
    @State private var editText: String
    @State private var size: CGSize = .zero
    
    @FocusState private var nameIsFocused:Bool
    @State private var nameIsFocusedAnimated:Bool
    
    
    init(form: WordForm, context: NSManagedObjectContext, _ wordFormType: WordFormsEnum) {
        self.form = form
        self.context = context
        self.wordFormType = wordFormType
        
        self.editText = form.str
        self.nameIsFocusedAnimated = false
        self.nameIsFocused = false
    }
    
    var body: some View {
        HStack {
            ZStack(alignment:.leading) {
                // view ниже служит лиш для получения
                // коректного размера для TextEditor
                Text(editText)
                    .padding(5)
                    .font(.title2)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .background(
                        Capsule()
                            .foregroundStyle(Color.gray.opacity(0.2))
                        
                    )
                    .overlay(
                        Capsule()
                            .stroke(.black, lineWidth: 1)
                    )
                    .padding(.leading,20)
                    .background(
                        // Беру размер, сгенирированный
                        // SwiftUI автоматически
                        // чтобы TextField имел размер Text
                        // при неактивном состоянии
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    size = proxy.size
                                }
                                .onChange(of: nameIsFocusedAnimated) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        size = proxy.size
                                    }
                                }
                        }
                    )
                    .opacity(0)
                
                HStack {
                    TextField(form.str, text:$editText )
                        .foregroundStyle(.black)
                        .padding(5)
                        .font(.title2)
                        .background(
                            Capsule()
                                .foregroundStyle(Color.gray.opacity(0.2))
                            
                        )
                        .overlay(
                            Capsule()
                                .stroke(.black, lineWidth: 1)
                        )
                        .padding(.leading,20)
                        .frame(width: nameIsFocusedAnimated ?  .infinity : size.width)
                        .focused($nameIsFocused)
                        .onChange(of: nameIsFocused) { _ ,newValue in
                            //анимируем views через эту переменную
                            withAnimation(.easeInOut(duration: 0.7)){
                                nameIsFocusedAnimated = nameIsFocused
                            }
                            if !newValue {
                                //при расфокусе автоматически
                                //сохраняем измененные данные
                                
                                editText = Functions.correct(str: editText, as: wordFormType)
                                
                                //если такая слоформа существует -
                                //удалить ее.
                                //иначе (если не пустая) изменить
                                //словоформу
                                if Functions.contains(str: editText, in: wordFormType, context) {
                                    if editText != form.str {
                                        self.delete()
                                    }
                                } else {
                                    if editText.isEmpty {
                                        self.delete()
                                    } else {
                                        self.edit {
                                            form.str = editText
                                        }
                                    }
                                }
                            }
                        }
                    
                    if !nameIsFocusedAnimated {
                        Button(role:.destructive) {
                            self.delete()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .offset(x:-10,y:-30)
                        .font(.headline)
                        .animation(.linear, value: nameIsFocused)
                    }
                }
            }
            
            if nameIsFocusedAnimated {
                Group {
                    Button(role:.destructive) {
                        //discart changes
                        self.edit(changes: {editText = form.str})
                        nameIsFocused = false
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                        
                    }
                    Button {
                        //save changes
                        nameIsFocused = false
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                    }
                }
                .font(.title2)
            }
            
            Spacer()
            
        }
    }
    
    //при использование удаления и изменения
    //не надо прописовать сохранение
    private func delete() {
        withAnimation(.easeInOut(duration: 0.1)) {
            context.delete(form)
            self.save()
        }
    }
    
    private func edit(changes:()->()) {
        withAnimation(.easeInOut(duration: 0.5)) {
            changes()
            self.save()
        }
        
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
}



fileprivate struct Test : View {
    var test: WordForm
    init() {
        let items = try? Provider.shared.viewContext.fetch(Functions.fetchRequest(as: .pref)) as? [WordForm]
        test = items!.first!
    }
    var body: some View {
        WordFormRow(form:test,context: Provider.shared.viewContext, .pref )
        
    }
}

#Preview {
    Test()
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
