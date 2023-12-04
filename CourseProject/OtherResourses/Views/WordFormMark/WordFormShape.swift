//
//  WordFormShape.swift
//  CourseProject
//
//  Created by admin on 4.12.23.
//

import Foundation
import SwiftUI
//
//struct PrefixShape : View {
//    var body: some View {
//        HStack {
//            Rectangle()
//                .frame(width: .infinity,height: 5)
//                .padding(.trailing,-8)
//            Rectangle()
//                .frame(width: 5)
//                .padding(.top,22.5)
//        }
//        .frame(height:50)
//
//    }
//}

struct PrefixShape : Shape {
    let lineWidth: CGFloat
    func path(in rect: CGRect) -> Path {
        Path { proxy in
            proxy.move(to: CGPoint(x: 0, y: 0))
            proxy.addLine(to: CGPoint(x: rect.width-4, y: 0))
            
            //            proxy.move(to: CGPoint(x: rect.maxX, y: 0))
            proxy.addLine(to: CGPoint(x:rect.width-4,y:rect.height-8.5))
            
            //            proxy.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            proxy.addLine(to: CGPoint(x: rect.width-lineWidth-4, y: rect.height-8.5))
            
            //            proxy.move(to: CGPoint(x: rect.maxX-10, y: rect.maxY))
            proxy.addLine(to: CGPoint(x: rect.width-lineWidth-4, y: lineWidth))
            
            //            proxy.move(to: CGPoint(x: rect.maxX-10, y:10))
            proxy.addLine(to: CGPoint(x: 0, y: lineWidth))
            
            //            proxy.move(to: CGPoint(x: 0, y: 10))
            proxy.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}

struct RootShape : Shape {
    func path(in rect: CGRect) -> Path {
        Path { proxy in
            proxy.move(to:CGPoint(x: 1, y: rect.height/2 ))
            
            proxy.addCurve(to: CGPoint(x: rect.width, y: rect.height/2), control1: CGPoint(x:1, y: rect.height/2-20), control2: CGPoint(x: rect.width, y: rect.height/2-20))
        }
    }
}

struct SuffixShape : Shape {
    let lineWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { proxy in
            proxy.move(to: CGPoint(x: 0, y: rect.height))
            
            proxy.addLine(to: CGPoint(x: rect.width/2, y: 0))
            proxy.addLine(to: CGPoint(x: rect.width, y: rect.height))
            proxy.addLine(to: CGPoint(x: rect.width-lineWidth, y: rect.height))
            
            proxy.addLine(to: CGPoint(x: rect.width/2, y: lineWidth))
            proxy.addLine(to: CGPoint(x: lineWidth, y: rect.height))
            proxy.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

struct PostfixShape : Shape {
    // чем больше height, тем
    //ниже расположится фигура
    private let height: CGFloat = 9
    
    
    func path(in rect: CGRect) -> Path {
        Path { proxy in
            proxy.move(to: CGPoint(x: 0, y: height))
            
            proxy.addLine(to: CGPoint(x: rect.width, y:  height))
            proxy.addLine(to: CGPoint(x: rect.width, y: rect.height + height))
            proxy.addLine(to: CGPoint(x: 0, y: rect.height + height))
            proxy.addLine(to: CGPoint(x: 0, y: height))
        }
    }
}
    
    
    #Preview {
        HStack {

            Rectangle()
                .clipShape(SuffixShape(lineWidth: 2))
        }
        
    }
