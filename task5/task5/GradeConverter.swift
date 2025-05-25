//
//  GradeConverter.swift
//  task5
//
//   
//

import Foundation
	
import Combine

class GradeConverter: ObservableObject {
    @Published var mathAnalysis = ""
    @Published var geometry = ""
    @Published var programming = ""
    @Published var selectedSystem = 0
    
    let systems = [5, 12, 25]
    
    private func convertToSystem(_ grade: Int) -> Int {
        let percentage = Double(grade) / 10.0
        switch selectedSystem {
        case 0: return Int(round(percentage * 5))
        case 1: return Int(round(percentage * 12))
        case 2: return Int(round(percentage * 25))
        default: return 0
        }
    }
    
    func convertedGrades() -> (math: Int, geometry: Int, programming: Int, average: Double) {
        let mathGrade = Int(mathAnalysis) ?? 0
        let geometryGrade = Int(geometry) ?? 0
        let programmingGrade = Int(programming) ?? 0
        
        let convertedMath = convertToSystem(mathGrade)
        let convertedGeometry = convertToSystem(geometryGrade)
        let convertedProgramming = convertToSystem(programmingGrade)
        
        let average = Double(mathGrade + geometryGrade + programmingGrade) / 3.0
        let convertedAverage = convertToSystem(Int(average))
        
        return (convertedMath, convertedGeometry, convertedProgramming, Double(convertedAverage))
    }
    
    var isValidInput: Bool {
        [mathAnalysis, geometry, programming].allSatisfy {
            guard let grade = Int($0) else { return false }
            return (1...10).contains(grade)
        }
    }
}
