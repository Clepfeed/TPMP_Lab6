//
//  ResultView.swift
//  task5
//
//   
//

import Foundation
import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var converter: GradeConverter
    
    var body: some View {
        let grades = converter.convertedGrades()
        
        Form {
            Section(header: Text("Converted Grades")) {
                GradeResultRow(title: "Math Analysis", value: grades.math)
                GradeResultRow(title: "Geometry", value: grades.geometry)
                GradeResultRow(title: "Programming", value: grades.programming)
            }
            
            Section(header: Text("Average Grade")) {
                HStack {
                    Text("Average")
                    Spacer()
                    Text(String(format: "%.1f", grades.average))
                }
            }
        }
        .navigationTitle("Results")
    }
}

struct GradeResultRow: View {
    let title: LocalizedStringKey
    let value: Int
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(value)")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
            .environmentObject(GradeConverter())
    }
}
