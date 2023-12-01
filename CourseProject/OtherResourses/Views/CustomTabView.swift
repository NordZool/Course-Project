//
//  CustomTabView.swift
//  Course work
//
//  Created by admin on 3.11.23.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var wordFormNow: WordFormsEnum
    
    var body: some View {
        VStack {
            Spacer()
            Divider()
                HStack {
                    ForEach(WordFormsEnum.allCases, id: \.self) {form in
                        Button {
                            withAnimation(.linear(duration: 0.3)) {
                                wordFormNow = form
                            } //чтобы плавно между экранами переходило
                        } label: {
                            Text(form.rawValue)
                                .fontWeight(.bold)
                                .foregroundColor(wordFormNow == form ? .black : .gray)
                        }
                    }
            }
        }
    }
}


fileprivate struct bb : View {
    @State var wordFormNow = WordFormsEnum.pref
    var body: some View {
        CustomTabView(wordFormNow: $wordFormNow)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        bb()
    }
}
