//
//  ContentView.swift
//  task5
//
//  
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var converter: GradeConverter
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subjects")) {
                    GradeInputField(title: "Math Analysis", value: $converter.mathAnalysis)
                    GradeInputField(title: "Geometry", value: $converter.geometry)
                    GradeInputField(title: "Programming", value: $converter.programming)
                }
                
                Section(header: Text("Grading System")) {
                    Picker("System", selection: $converter.selectedSystem) {
                        ForEach(0..<converter.systems.count) { index in
                            Text("\(converter.systems[index])-point")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                NavigationLink(destination: ResultsView()) {
                    Text("Convert")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!converter.isValidInput)
            }
            .navigationTitle("Grade Converter")
        }
    }
}

struct GradeInputField: View {
    let title: LocalizedStringKey
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("1-10", text: $value)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GradeConverter())
    }
}
