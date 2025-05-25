//
//  task5App.swift
//  task5
//
//   
//

import SwiftUI

@main
struct GradeConverterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GradeConverter())
        }
    }
}
