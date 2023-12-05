//
//  MainScreenButtonModifier.swift
//  CourseProject
//
//  Created by admin on 30.11.23.
//

import Foundation
import SwiftUI

struct MainScreenButtonModifier : ViewModifier {
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
        //сделать жирность
            .foregroundStyle(.black)
            .padding(5)
            .overlay(
                Capsule()
                    .stroke(lineWidth: 3)
                    .foregroundStyle(.black)
            )
    }
}

extension View {
    func buttonModifier(_ font:Font) -> some View {
        self.modifier(MainScreenButtonModifier(font: font))
    }
}
