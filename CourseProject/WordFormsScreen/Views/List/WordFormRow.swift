//
//  WordFormRow.swift
//  Course
//
//  Created by admin on 22.11.23.
//

import SwiftUI
import CoreData

struct WordFormRow: View {
    //for save
    var managedObjectContext: NSManagedObjectContext
    
    @ObservedObject var item: WordForm
    
    @State private var editText: String
    @State private var size: CGSize = .zero
    
    @FocusState private var nameIsFocused:Bool
    @State private var nameIsFocusedAnimated:Bool
    
    
    init(item: WordForm,_ moc: NSManagedObjectContext) {
        self.managedObjectContext = moc
        self.item = item
        self.editText = item.str
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
                        TextField("Ввод...", text:$editText )
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
                                    //при расфокусе автоматически
                                    //сохраняем измененные данные
                                }
                                if !newValue {
                                    self.edit(changes: {item.str = editText})
                                }
                            }
                        
                        if !nameIsFocusedAnimated {
                            Button(role:.destructive) {
                                //save видос ниги как удалять
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
                        self.edit(changes: {editText = item.str})
                        nameIsFocused = false
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                        
                    }
                    Button {
                        //save accept
                        self.edit(changes: {item.str = editText})
                        nameIsFocused = false
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                    }
                }
                .font(.title2)
            }
            

                //Подвинуть чуть выше овала
                
                Spacer()
            
        }
    }
    
    //при использование удаления и изменения
    //не надо прописовать сохранение
    private func delete() {
        withAnimation(.easeInOut(duration: 0.1)) {
            managedObjectContext.delete(item)
            self.save()
        }
    }
    
    private func edit(changes:()->()) {
        withAnimation(.easeInOut(duration: 0.7)) {
            changes()
            self.save()
        }
        
    }
    
    private func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
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
        WordFormRow(item: test, Provider.shared.viewContext)
            
    }
}

#Preview {
    Test()
        .environment(\.managedObjectContext, Provider.shared.viewContext)
}
