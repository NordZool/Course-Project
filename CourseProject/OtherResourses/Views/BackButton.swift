//
//  BackButton.swift
//  Course work
//
//  Created by admin on 8.11.23.
//

import SwiftUI

//использовать только в ZStack

struct BackButton: View {
    @Environment (\.dismiss) var goBack
    var body: some View {
        HStack {
            VStack {
                Button {
                    goBack.callAsFunction()
                } label: {
                    HStack(spacing:5) {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                }
                .padding(.leading,10)
                Spacer()
            }
            Spacer()
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
