//
//  WordFormMark.swift
//  CourseProject
//
//  Created by admin on 4.12.23.
//

import SwiftUI

struct WordFormMark: View {
    var wordFormType: WordFormsEnum
    
    private let lineWidth:CGFloat = 2
    
    init(as wordFormType: WordFormsEnum) {
        self.wordFormType = wordFormType
    }
    
    var body: some View {
        switch wordFormType {
        case .pref:
            PrefixShape(lineWidth: lineWidth)
                .wordFormMarkModefier()
                .padding(.trailing,-4)
        case .rt:
            RootShape()
                .stroke(lineWidth: lineWidth)
                .wordFormMarkModefier()
                .padding(.leading,0.5)
                .offset(y:1)
            
            
        case .suf:
            SuffixShape(lineWidth: lineWidth+1)
                .wordFormMarkModefier()
                .padding(.leading,1)
                .offset(y:-9)
        case .postf:
            PostfixShape()
                .stroke(lineWidth: lineWidth-1)
                .wordFormMarkModefier()
                .offset(y:5)
            
        }
    }
}

fileprivate struct WordFormMarkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 20)
            .padding(.bottom,-19)
    }
}

fileprivate extension View {
    func wordFormMarkModefier() -> some View{
        self.modifier(WordFormMarkModifier())
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing:0) {
            ForEach(WordFormsEnum.allCases, id: \.self) { wordForm in
                VStack {
                    WordFormMark(as: wordForm)
                    Text("рсвлслв")
                    
                }
                .padding(.vertical)
            }
        }
    }
    .frame(height:300)
}
