//
//  CourseProjectApp.swift
//  CourseProject
//
//  Created by admin on 30.11.23.
//

import SwiftUI

@main
struct CourseProjectApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.managedObjectContext, Provider.shared.viewContext)
        }
    }
}
