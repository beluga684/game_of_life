import Foundation

final class GameEngine {
    private let calculator: GenerationCalculator
    private(set) var grid: Grid
    
    init(calculator: GenerationCalculator, grid: Grid) {
        self.calculator = calculator
        self.grid = grid
    }
    
    // Следующее поколение
    func advance() {
        grid = calculator.nextGeneration(from: grid)
    }
    
    // Изменение состояния клетки
    func toggleCell(row: Int, col: Int) {
        grid.toggleCell(row: row, column: col)
    }
    
    // Очистка поля
    func clear() {
        fatalError("Implement")
    }
    
    // Случайная генерация
    func randomize() {
        fatalError("Implement")
    }
}
