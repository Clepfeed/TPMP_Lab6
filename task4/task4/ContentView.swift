//
//  ContentView.swift
//  task4
//
//  
//

import SwiftUI

struct ContentView: View {
    // MARK: - Состояния (State Variables)
    // Эти переменные автоматически обновляют интерфейс при изменении
    
    @State private var red: Double = 0.5       // Значение красного канала (0-1)
    @State private var green: Double = 0.5     // Значение зеленого канала
    @State private var blue: Double = 0.5      // Значение синего канала
    @State private var targetColor = Color.random // Случайный целевой цвет
    @State private var showAlert = false       // Показывать ли алерт
    @State private var score = 0               // Текущий процент совпадения
    @State private var attempts = 0            // Количество попыток
    @State private var gameWon = false         // Флаг победы
    @State private var hints: [String] = []    // Массив подсказок
    
    // MARK: - Основной интерфейс
    var body: some View {
        VStack(spacing: 20) {
            // 1. Блоки цветов
            HStack(spacing: 40) {
                ColorBlock(title: "Target", color: targetColor)
                ColorBlock(title: "Your Guess", color: Color(red: red, green: green, blue: blue))
            }
            
            // 2. Подсказки (появляются после первой попытки)
            if !hints.isEmpty {
                VStack(alignment: .leading) {
                    Text("Hints:")
                        .font(.headline)
                    ForEach(hints, id: \.self) { hint in
                        Text(hint)
                            .foregroundColor(.secondary)
                    }
                }
                .transition(.opacity) // Анимация появления
            }
            
            // 3. Слайдеры для управления цветом
            VStack(spacing: 15) {
                SliderView(value: $red, color: .red)
                SliderView(value: $green, color: .green)
                SliderView(value: $blue, color: .blue)
            }
            .padding(.horizontal)
            
            // 4. Основная кнопка (меняет действие и цвет при победе)
            Button(gameWon ? "New Game" : "Check Guess") {
                gameWon ? resetGame() : checkGuess()
            }
            .font(.title)
            .padding()
            .background(gameWon ? Color.green : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // 5. Счетчик попыток
            Text("Attempts: \(attempts)")
                .font(.headline)
        }
        .padding()
        .animation(.default, value: hints) // Анимация изменений
        .alert(gameWon ? "Congratulations!" : "Try Again", isPresented: $showAlert) {
            Button(gameWon ? "Play Again" : "Continue") {
                if gameWon { resetGame() }
            }
        } message: {
            if gameWon {
                Text("You won in \(attempts) attempts!\nFinal score: \(score)%")
            } else {
                Text("Current score: \(score)%")
            }
        }
    }
    
    // MARK: - Игровая логика
    
    /// Проверяет совпадение цветов и обновляет состояние игры
    func checkGuess() {
        attempts += 1
        let guessColor = Color(red: red, green: green, blue: blue)
        
        // Расчет разницы между цветами (0-1)
        let difference = calculateDifference(target: targetColor, guess: guessColor)
        
        // Конвертация в проценты (100% = полное совпадение)
        score = Int(100 - (difference * 100))
        
        // Проверка победы (90% совпадение)
        gameWon = score >= 90
        
        // Генерация подсказок
        generateHints(target: targetColor, guess: guessColor)
        
        showAlert = true
    }
    
    /// Сбрасывает игру к начальному состоянию
    func resetGame() {
        targetColor = .random
        red = 0.5
        green = 0.5
        blue = 0.5
        attempts = 0
        hints.removeAll()
        gameWon = false
    }
    
    /// Вычисляет разницу между двумя цветами
    func calculateDifference(target: Color, guess: Color) -> Double {
        let t = target.components
    let g = guess.components
        // Сумма абсолютных разниц по каждому каналу
        return abs(t.red - g.red) + abs(t.green - g.green) + abs(t.blue - g.blue)
    }
    
    /// Генерирует подсказки для пользователя
    func generateHints(target: Color, guess: Color) {
        hints.removeAll()
        let t = target.components
        let g = guess.components
        
        // Анализ каждого цветового канала
        if g.red < t.red - 0.1 {
            hints.append("• Increase RED slider")
        } else if g.red > t.red + 0.1 {
            hints.append("• Decrease RED slider")
        }
        
        if g.green < t.green - 0.1 {
            hints.append("• Increase GREEN slider")
        } else if g.green > t.green + 0.1 {
            hints.append("• Decrease GREEN slider")
        }
        
        if g.blue < t.blue - 0.1 {
            hints.append("• Increase BLUE slider")
        } else if g.blue > t.blue + 0.1 {
            hints.append("• Decrease BLUE slider")
        }
        
        // Если все значения близки к целевым
        if hints.isEmpty {
            hints.append("Almost perfect! Adjust slightly")
        }
    }
}

// MARK: - Вспомогательные компоненты

/// Блок для отображения цвета с подписью
struct ColorBlock: View {
    let title: String
    let color: Color
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 150, height: 150)
                .foregroundColor(color)
                .cornerRadius(10)
            Text(title)
                .font(.headline)
        }
    }
}

/// Кастомный слайдер с подписью значения
struct SliderView: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(Int(value * 255))") // Отображение значения 0-255
                .frame(width: 40)
            Slider(value: $value)
                .accentColor(color) // Цвет слайдера
        }
    }
}

// MARK: - Расширения для Color

extension Color {
    /// Генерирует случайный цвет
    static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    
    /// Возвращает RGB-компоненты цвета
    var components: (red: Double, green: Double, blue: Double) {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (Double(red), Double(green), Double(blue))
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
